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
            backgroundColor: Colors.blue[50],
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Enose",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'WELCOME!',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                      //  height: 100.0,
                      //width: 200.0,
                      child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        hintText: 'example@domain.com',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 3), // add padding to adjust icon
                          child: Icon(Icons.email, size: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email cannot be empty';
                      }
                      return null;
                    },
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      //height: 100.0,
                      // width: 200.0,
                      child: TextFormField(
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
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: 3), // add padding to adjust icon
                          child: Icon(Icons.password, size: 20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Please enter a password longer than 8 characters';
                      }
                      return null;
                    },
                  )),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        primary: Colors.blueGrey,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                            // connect();
                          });
                          dynamic result = await _auth.signin(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              // error = 'Wrong email or password';
                              print(email);
                              print(password);
                            });
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => location()));
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Incorrect Email or Password')),
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
                        height: 10,
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
                    height: 100,
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
