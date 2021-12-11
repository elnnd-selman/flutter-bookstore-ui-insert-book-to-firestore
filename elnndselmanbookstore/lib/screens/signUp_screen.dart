import 'dart:io';

import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/user_info_model.dart';
import 'package:avreenbooks/provider/firebaseAuth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final _form = GlobalKey<FormState>();
  final _confirmPassword = TextEditingController();
  var _userInfo = UserInfoModel(name: '', email: '', password: '');
  bool signUp = false;
  bool sec = true;
  bool load = false;
  File file;
  AnimationController _controller;
  Animation<Size> _heightAnimation;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<Size>(
      begin: Size(double.infinity, 250),
      end: Size(double.infinity, 300),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _heightAnimation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _confirmPassword.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context).settings.arguments as String;
    void _uploadImage() async {
      final _picker = ImagePicker();
      PickedFile _image = await _picker.getImage(source: ImageSource.gallery);
      if (_image != null) {
        setState(() {
          file = File(_image.path);
        });
      }
    }

    Future<void> _signUpAndLogin() async {
      _form.currentState.save();
      final isValed = _form.currentState.validate();
      if (isValed) {
        if (signUp) {
          setState(() {
            load = !load;
          });
          if (file != null) {
            await Provider.of<FirebaseAuth_provider>(context, listen: false)
                .signInToFirebaseAuth(
                    _userInfo.name, _userInfo.email, _userInfo.password, file);
            setState(() {
              load = !load;
            });
            await Navigator.pushReplacementNamed(context, route);
          }
        } else if (!signUp) {
          setState(() {
            load = !load;
          });
          await Provider.of<FirebaseAuth_provider>(context, listen: false)
              .loginInToFirebaseAuth(_userInfo.email, _userInfo.password);
          setState(() {
            load = !load;
          });
          await Navigator.pushReplacementNamed(context, route);
        }
      } else {
        print('no valed');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          // color: Colors.blueGrey[200],
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [one, greenCirculer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // stops: [0.3, 1],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _form,
                    child: Expanded(
                      child: ListView(
                        children: [
                          //image///////////////////////////////////////////////
                          AnimatedPadding(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                                horizontal: signUp ? 25 : 0),
                            child: Container(
                              margin: EdgeInsets.only(right: 15, top: 30),
                              // height: signUp ? 250 : 300,
                              height: _heightAnimation.value.height,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child:
                                    Image.asset('assets/images/lalavook.png'),
                              ),
                            ),
                          ),
                          signUp
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(color: one, width: 3)),
                                  alignment: Alignment.centerLeft,
                                  // margin: EdgeInsets.only(left: 53),
                                  height: 100,
                                  width: 100,
                                  child: file != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: FileImage(file),
                                        )
                                      : CircleAvatar(
                                          radius: 50,
                                          backgroundColor: one,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 18, bottom: 18),
                                            child: Center(
                                              child: IconButton(
                                                  icon: Icon(Icons.image,
                                                      size: 50),
                                                  onPressed: _uploadImage),
                                            ),
                                          ),
                                        ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          signUp
                              ? SizedBox(
                                  height: 0,
                                )
                              : SizedBox(
                                  height: 73,
                                ),
                          //text/////////////////////////////////////////////////
                          signUp
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                        enabled: !load,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value.length < 3) {
                                            return 'name not valed ,ust be gretter than 3';
                                          }
                                          // if (isNumeric(value) == false) {
                                          //   print(isNumeric(value));
                                          //   return 'invaled name, name must not contain any number ';
                                          // }
                                          return null;
                                        },
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        decoration: InputDecoration(
                                          errorStyle:
                                              TextStyle(color: Colors.red),
                                          filled: true,
                                          fillColor: one,
                                          border: OutlineInputBorder(),
                                          labelText: 'name',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          contentPadding:
                                              const EdgeInsets.all(22),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: greenCirculer),
                                            borderRadius:
                                                BorderRadius.circular(15.7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: one),
                                            borderRadius:
                                                BorderRadius.circular(15.7),
                                          ),
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Icon(
                                              Icons.person,
                                              color: greenCirculer,
                                            ),
                                          ),
                                        ),
                                        onSaved: (value) {
                                          _userInfo = UserInfoModel(
                                              name: value,
                                              email: _userInfo.email,
                                              password: _userInfo.password);
                                        }),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          ////////////////////////////////////////
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                  validator: (value) {
                                    if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'invaled email';
                                    }
                                    if (value.length < 7) {
                                      return 'invaled email';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: one,
                                    border: OutlineInputBorder(),
                                    labelText: 'email',
                                    labelStyle: TextStyle(color: Colors.white),
                                    contentPadding: const EdgeInsets.all(22),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: greenCirculer),
                                      borderRadius: BorderRadius.circular(15.7),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: one),
                                      borderRadius: BorderRadius.circular(15.7),
                                    ),
                                    prefixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Icon(
                                        Icons.email,
                                        color: greenCirculer,
                                      ),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    _userInfo = UserInfoModel(
                                        name: _userInfo.name,
                                        email: value,
                                        password: _userInfo.password);
                                  }),
                            ),
                          ),
                          ////////////////////////////////////////
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: TextFormField(
                                obscureText: sec,
                                controller: _confirmPassword,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: one,
                                  border: OutlineInputBorder(),
                                  labelText: 'password',
                                  labelStyle: TextStyle(color: Colors.white),
                                  contentPadding: const EdgeInsets.all(22),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: greenCirculer),
                                    borderRadius: BorderRadius.circular(15.7),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: one),
                                    borderRadius: BorderRadius.circular(15.7),
                                  ),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.security,
                                      color: greenCirculer,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          sec = !sec;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye_sharp,
                                        color:
                                            sec ? Colors.grey : greenCirculer,
                                      )),
                                ),
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  _userInfo = UserInfoModel(
                                      name: _userInfo.name,
                                      email: _userInfo.email,
                                      password: value);
                                },
                              ),
                            ),
                          ),
                          ////////////////////////////////
                          signUp
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: TextFormField(
                                      obscureText: sec,
                                      validator: (value) {
                                        if (value != _confirmPassword.text) {
                                          return 'passwrod not match';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: one,
                                        border: OutlineInputBorder(),
                                        labelText: 'confirm password',
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        contentPadding:
                                            const EdgeInsets.all(22),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: greenCirculer),
                                          borderRadius:
                                              BorderRadius.circular(15.7),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: one),
                                          borderRadius:
                                              BorderRadius.circular(15.7),
                                        ),
                                        prefixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Icon(
                                            Icons.security,
                                            color: greenCirculer,
                                          ),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              !load
                                  ? TextButton.icon(
                                      icon: Icon(
                                        Icons.login,
                                        color: one,
                                        size: 30,
                                      ),
                                      label: Text(
                                        signUp ? 'Sign up' : 'login',
                                        style: TextStyle(
                                            color: one,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: _signUpAndLogin,
                                    )
                                  : Center(child: CircularProgressIndicator()),
                              TextButton(
                                child: Text(
                                  signUp
                                      ? 'already have account!'
                                      : ' have not account!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                onPressed: () {
                                  setState(() {
                                    signUp = !signUp;
                                    if (signUp) {
                                      _controller.forward();
                                    } else {
                                      _controller.reverse();
                                    }
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
