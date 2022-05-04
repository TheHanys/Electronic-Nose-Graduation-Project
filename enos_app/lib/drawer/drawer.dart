import 'package:enos_app/models/user.dart';
import 'package:enos_app/screens/alerthistory.dart';
import 'package:enos_app/screens/readtxt.dart';
import 'package:enos_app/services/auth.dart';
import 'package:enos_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/screens/signin.dart';
import 'package:enos_app/screens/home_page.dart';
import 'package:enos_app/screens/profile.dart';
import 'package:enos_app/screens/aboutus.dart';
import 'package:provider/provider.dart';
import 'package:enos_app/screens/location_page.dart';

class MyDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Myuser?>(context);
    if (user == null) {
      return Signin();
    }
    return StreamBuilder<Myuser?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            return Drawer(
              child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  accountName: Text(userdata.name!),
                  accountEmail: Text(''),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      userdata.downloadURL!,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Home page'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profile()));
                  },
                ),
                ListTile(
                  title: Text('Alerts History'),
                  leading: Icon(Icons.shopping_basket_outlined),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => History()));
                  },
                ),
                ListTile(
                  title: Text('Location'),
                  leading: Icon(Icons.location_on),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => locationn()));
                  },
                ),
                // ListTile(
                //  title: Text('upload file'),
                //  leading: Icon(Icons.location_on),
                //  onTap: () {
                //    Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => uploadfile()));
                //  },
                //  ),
                ListTile(
                  title: Text('About us'),
                  leading: Icon(Icons.support_agent),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => aboutus()));
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout),
                  onTap: () async {
                    await _auth.signout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ]),
            );
          } else {
            return Container();
          }
        });
  }
}
