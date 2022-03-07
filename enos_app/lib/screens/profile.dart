import 'package:enos_app/models/user.dart';
import 'package:enos_app/screens/signin.dart';
import 'package:enos_app/services/database.dart';
import 'package:enos_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:enos_app/screens/editProfile.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    Myuser? user = Provider.of<Myuser?>(context);
    if (user == null) {
      return Signin();
    }
    return StreamBuilder<Myuser?>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text('profile'),
                backgroundColor: Colors.red,
              ),
              drawer: MyDrawer(),
              body: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      userdata.downloadURL!,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(
                    'Name: ' + userdata.name!,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    'Username: ' + userdata.userName!,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    'Phone: ' + userdata.phoneNumber!,
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editProfile()));
                        setState(() {});
                      },
                      child: Text("Edit profile")),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
