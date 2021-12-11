import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firebaseAuth_provider.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/editing_list_screen.dart';
import 'package:avreenbooks/screens/home.dart';
import 'package:avreenbooks/screens/signUp_screen.dart';
import 'package:avreenbooks/screens/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user != null
                        ? FutureBuilder(
                            future: Provider.of<FirestoreClass>(context)
                                .getUserByIdFromFireStore(user.uid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data.name == null ||
                                  snapshot.data.imageProfileUrl == null) {
                                return Center(
                                  child: Text('data nya'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Text('data loada'),
                                );
                              }

                              return ListTile(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/user-profile-screen');
                                },
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      snapshot.data.imageProfileUrl),
                                ),
                                title: Text(
                                  snapshot.data.name,
                                  style: TextStyle(fontSize: 16),
                                ),
                                subtitle: Text('user'),
                              );
                            },
                          )
                        : TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignUp.routeName,
                                  arguments: Home.routeName);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(color: one),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                    Divider(
                      height: 10,
                      endIndent: 10,
                      // indent: 10,
                      color: one,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Home.routeName);
                      },
                      icon: Icon(Icons.shop_outlined, color: Colors.black),
                      label: Text(
                        'Home',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, EditinListScreen.routeName);
                      },
                      icon: Icon(Icons.edit, color: Colors.black),
                      label: Text(
                        'Editing list',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              user != null
                  ? Container(
                      color: redList,
                      width: 300,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.routeName,
                              arguments: Home.routeName);
                        },
                        child: TextButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await Provider.of<FirebaseAuth_provider>(context,
                                    listen: false)
                                .signOut();
                          },
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
