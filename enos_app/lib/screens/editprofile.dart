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
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        //controller: name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: userdata.name),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Name';
                          }
                          _currentname = value;
                          return null;
                        },
                      ),
                      TextFormField(
                        //controller: userName,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: userdata.userName),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          _currentusername = value;
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: userdata.phoneNumber),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          _currentphonenumber = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
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
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text('update information')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () async {
                            await DatabaseService(uid: userdata.uid)
                                .updateUserData(
                              _currentname ?? userdata.name,
                              _currentusername ?? userdata.userName,
                              _currentphonenumber ?? userdata.phoneNumber,
                              _downloadURL ?? userdata.downloadURL,
                              _location ?? userdata.location,
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => location()));
                          },
                          child: Text('update location'))
                    ],
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
