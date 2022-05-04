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
                backgroundColor: Colors.blueGrey,
              ),
              drawer: MyDrawer(),
              body: ListView(
                children: [
                  SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      userdata.downloadURL!,
                      height: 130.0,
                      width: 130.0,
                    ),
                  ),
                  SizedBox(height: 100),
                  Text('Name: ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center),
                  Text(userdata.name!,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('Username: ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center),
                  Text(userdata.userName!,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('Phone number: ',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center),
                  Text(userdata.phoneNumber!,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center),
                  SizedBox(height: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        primary: Colors.blueGrey,
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
