import 'package:enos_app/models/user.dart';
import 'package:enos_app/screens/home_page.dart';
import 'package:enos_app/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Myuser?>(context);
    print(user);

    if (user == null) {
      return Signin();
    } else {
      return HomePage();
    }
  }
}
