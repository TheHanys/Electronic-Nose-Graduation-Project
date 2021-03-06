import 'dart:ffi';
import 'dart:io';
import 'package:enos_app/screens/location.dart';
import 'package:enos_app/services/database.dart';
import 'package:enos_app/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class locationn extends StatefulWidget {
  const locationn({Key? key}) : super(key: key);

  @override
  _locationn createState() => _locationn();
}

class _locationn extends State<locationn> {
  final _formkey = GlobalKey<FormState>();

  String? _currentname;
  String? _currentusername;
  String? _currentphonenumber;
  File? _image;
  final imagePicker = ImagePicker();
  String? _downloadURL;
  String? userid;
  String? _location;
  bool? _isuserhome;
  List? _msgs;

  Future uploadimage({String? userid}) async {
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref =
        FirebaseStorage.instance.ref().child('${userid}').child('post_$postID');
    await ref.putFile(_image!);
    _downloadURL = await ref.getDownloadURL();
    return _downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Myuser?>(context);
    return StreamBuilder<Myuser?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      AppBar(
                        title: Text('Location'),
                        backgroundColor: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Are you at home?",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Switch(
                        value: userdata.isuserhome!,
                        onChanged: (value) async {
                          if (userdata.isuserhome == true) {
                            userdata.isuserhome = false;
                            await DatabaseService(uid: userdata.uid)
                                .updateUserData(
                              _currentname ?? userdata.name,
                              _currentusername ?? userdata.userName,
                              _currentphonenumber ?? userdata.phoneNumber,
                              _downloadURL ?? userdata.downloadURL,
                              _location ?? userdata.location,
                              _isuserhome ?? userdata.isuserhome,
                              _msgs ?? userdata.msgs,
                            );
                            setState(() {
                              userdata.isuserhome = value;
                            });

                            print(userdata.isuserhome);
                          } else if (userdata.isuserhome == false) {
                            userdata.isuserhome = true;
                            await DatabaseService(uid: userdata.uid)
                                .updateUserData(
                              _currentname ?? userdata.name,
                              _currentusername ?? userdata.userName,
                              _currentphonenumber ?? userdata.phoneNumber,
                              _downloadURL ?? userdata.downloadURL,
                              _location ?? userdata.location,
                              _isuserhome ?? userdata.isuserhome,
                              _msgs ?? userdata.msgs,
                            );
                            setState(() {
                              userdata.isuserhome = value;
                            });
                          }
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      SizedBox(
                        height: 40,
                      ),
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
                                    builder: (context) => location()));
                          },
                          child: Text('update your location'))
                    ],
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
