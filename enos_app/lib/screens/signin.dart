import 'package:enos_app/screens/home_page.dart';
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
            backgroundColor: Colors.blue[50],
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(' Sense For Me'),
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'enter your email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        )),
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
                    height: 80,
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
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Create an account?'),
                      TextButton(
                        child: Text(
                          'Sign up',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueGrey),
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
                  SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      Text(
                        error,
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 14.0),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            ));
  }
}
