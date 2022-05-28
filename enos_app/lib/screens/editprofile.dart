import 'dart:io';
import 'package:enos_app/services/database.dart';
import 'package:enos_app/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  _editProfile createState() => _editProfile();
}

class _editProfile extends State<editProfile> {
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
                        title: Text('Edit Profile'),
                        backgroundColor: Colors.blueGrey,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            hintText: userdata.name),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please update Name';
                          }
                          _currentname = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            hintText: userdata.userName),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'username cannot be empty';
                          }
                          _currentusername = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            hintText: userdata.phoneNumber),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone number cannot be empty';
                          }
                          _currentphonenumber = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
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
                              Navigator.pop(context);
                            }
                          },
                          child: Text('update information')),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
