import 'dart:ffi';

import 'package:enos_app/screens/home_page.dart';
import 'package:enos_app/services/auth.dart';
import 'package:enos_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/screens/signin.dart';
import 'package:enos_app/screens/location.dart';

class account extends StatefulWidget {
  //const account({Key? key}) : super(key: key);

  @override
  _accountState createState() => _accountState();
}

class _accountState extends State<account> {
  String email = '';
  String password = '';
  String username = '';
  String name = '';
  String phonenumber = '';
  String downloadURL = 'https://www.un.org/sites/un2.un.org/files/user.png';
  String error = '';
  String location = '';
  String fileURL = '';
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool? isuserhome;
  List? msgs;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[50],
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  //AppBar(
                  // title: Text('Sign up'),
                  //  backgroundColor: Colors.blueGrey,
                  //  ),
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'Enose',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    validator: (namevalue) {
                      if (namevalue == null || namevalue.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (passvalue) {
                      if (passvalue == null || passvalue.isEmpty) {
                        return 'Please enter password';
                      } else if (passvalue.length < 8) {
                        return 'Please enter a password longer than 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (emailvalue) {
                      if (emailvalue == null || emailvalue.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your username',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    validator: (usernamevalue) {
                      if (usernamevalue == null || usernamevalue.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your phone number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0))),
                    onChanged: (value) {
                      setState(() {
                        phonenumber = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    validator: (phonenumbervalue) {
                      if (phonenumbervalue == null ||
                          phonenumbervalue.isEmpty ||
                          phonenumbervalue.length != 11) {
                        return 'Phone number is not correct';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.blueGrey,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.register(
                            name,
                            password,
                            email,
                            username,
                            phonenumber,
                            downloadURL,
                            location,
                            isuserhome,
                            msgs,
                            // fileURL,
                          );
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'email already registered';
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signin()));
                          }
                        }
                      },
                      child: Text('Sign up')),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text('Already have an account ?'),
                      TextButton(
                        child: Text(
                          'Sign in',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            ));
  }
}
