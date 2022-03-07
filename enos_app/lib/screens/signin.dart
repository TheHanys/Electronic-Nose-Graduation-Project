import 'package:enos_app/screens/home_page.dart';
import 'package:enos_app/screens/location.dart';
import 'package:enos_app/services/auth.dart';
import 'package:enos_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/screens/sign_up.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
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
                    backgroundColor: Colors.red,
                    title: Text('Sign in'),
                  ),
                  SizedBox(
                    height: 80,
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
                    height: 80,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'E-mail'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'password', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 8) {
                        return 'Please enter a password longer than 8 characters';
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
                          dynamic result = await _auth.signin(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Wrong email or password';
                              print(email);
                              print(password);
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('processing')),
                          );
                        }
                      },
                      child: Text('Sign in')),
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text('dont have an account?'),
                      TextButton(
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => account()),
                          );
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Column(
                    children: [
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
