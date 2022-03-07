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
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  AppBar(
                    title: Text('Sign up'),
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            'ENose',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                    validator: (namevalue) {
                      if (namevalue == null || namevalue.isEmpty) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'password', border: OutlineInputBorder()),
                    validator: (passvalue) {
                      if (passvalue == null || passvalue.isEmpty) {
                        return 'Please enter password';
                      } else if (passvalue.length < 8) {
                        return 'Please enter a password longer than 8 characters';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email'),
                    validator: (emailvalue) {
                      if (emailvalue == null || emailvalue.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Username'),
                    validator: (usernamevalue) {
                      if (usernamevalue == null || usernamevalue.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        phonenumber = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone number',
                    ),
                    validator: (phonenumbervalue) {
                      if (phonenumbervalue == null ||
                          phonenumbervalue.isEmpty) {
                        return 'Please enter your phone';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
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
                          style: TextStyle(fontSize: 20, color: Colors.red),
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
