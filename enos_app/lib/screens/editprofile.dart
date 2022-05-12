import 'dart:io';
import 'package:enos_app/screens/location.dart';
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
  //String? _fileURL;

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
          //print(snapshot.hasData);
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            // print(userdata.name);
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
                        //controller: name,
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
                        //controller: userName,
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
                            return 'Please update username';
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
                            return 'Please update phone number';
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

                                //   _fileURL ?? userdata.fileURL,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text('update information')),
                      SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.blueGrey,
                          ),
                          onPressed: () async {
                            print(userdata.downloadURL);
                            final pick = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pick != null) {
                              _image = File(pick.path);
                              uploadimage(userid: userdata.uid);

                              //print(_downloadURL);
                              const snackBar = SnackBar(
                                content: Text('image ready to be uploaded!'),
                              );
                              print(_downloadURL);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              //print(userdata.downloadURL);
                            } else {
                              print('error uploading image');
                              const snackBarerror = SnackBar(
                                content: Text('Error uploading image!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarerror);
                            }
                          },
                          child: Text('choose profile picture')),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            primary: Colors.blueGrey,
                          ),
                          onPressed: () async {
                            await DatabaseService(uid: userdata.uid)
                                .updateUserData(
                              _currentname ?? userdata.name,
                              _currentusername ?? userdata.userName,
                              _currentphonenumber ?? userdata.phoneNumber,
                              _downloadURL ?? userdata.downloadURL,
                              _location ?? userdata.location,
                              _isuserhome ?? userdata.isuserhome,
                              _msgs ?? userdata.msgs,
                              // _fileURL ?? userdata.fileURL,
                            );
                            if (_downloadURL == null) {
                              const snackBarup = SnackBar(
                                content: Text('error uploading image!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarup);
                            } else {
                              const snackBarup = SnackBar(
                                content: Text('image uploaded successfully!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBarup);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('update profile picture')),
                      SizedBox(
                        height: 10,
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
