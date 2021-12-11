import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firebaseAuth_provider.dart';
import 'package:avreenbooks/screens/editing_list_screen.dart';
import 'package:avreenbooks/screens/home.dart';
import 'package:avreenbooks/screens/signUp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDialogAlert {
  bool hide = true;
  bool signUp = false;
  final _name = TextEditingController();
  final _password = TextEditingController();
  DialogSignIn(BuildContext context, String what) async {
    showDialog(
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
              child: AlertDialog(
                backgroundColor: one,
                actionsOverflowButtonSpacing: 10,
                content: Container(
                  padding: EdgeInsets.all(10),
                  height: 230,
                  child: Column(
                    children: [
                      Text('پێوویستە بچیتە ژوورەروە',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: greenCirculer),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: greenCirculer,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: one,
                        ),
                        controller: _name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        obscureText: hide ? true : false,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: greenCirculer,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: one,
                        ),
                        controller: _password,
                      ),
                      signUp
                          ? TextField(
                              obscureText: hide ? true : false,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: greenCirculer,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: one,
                              ),
                              controller: _password,
                            )
                          : SizedBox(
                              height: 0,
                            )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _name.clear();
                      _password.clear();
                      Navigator.pop(context, 'signUp');
                    },
                    child: Text('!هەژمارم نیە',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'pop');
                    },
                    child: Text('دایخە',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<FirebaseAuth_provider>(context,
                              listen: false)
                          .loginInToFirebaseAuth(_name.text, _password.text);

                      _name.clear();
                      _password.clear();
                      if (Provider.of<User>(context, listen: false) != null) {
                        Navigator.pop(context, 'login');
                      }
                    },
                    child: Text('باشە',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            )).then((value) {
      if (value == null) {
        print('is null');
      }
      if (value == 'login') {
        if (what == 'nothing') {
          Navigator.pushNamed(context, EditinListScreen.routeName);
        } else {
          Navigator.pushNamed(context, Home.routeName);
        }
      }
      if (value == 'signUp') {
        Navigator.pushNamed(context, SignUp.routeName,
            arguments: what == 'nothing'
                ? EditinListScreen.routeName
                : Home.routeName);
      }
    });
  }
}
