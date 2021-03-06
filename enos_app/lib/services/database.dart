import 'dart:ffi';

import 'package:enos_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('userdata');

  Future updateUserData(
    String? name,
    String? username,
    String? phonenumber,
    String? downloadURL,
    String? location,
    bool? isuserhome,
    List? msgs,
  ) async {
    return await userdata.doc(uid).set({
      'name': name,
      'username': username,
      'phonenumber': phonenumber,
      'downloadURL':
          downloadURL ?? "https://www.un.org/sites/un2.un.org/files/user.png",
      'location': location,
      'isuserhome': isuserhome ?? false,
      'msgs': msgs,
    });
  }

  Myuser _userDatafromsnapshot(DocumentSnapshot snapshot) {
    return Myuser(
      uid: uid,
      name: snapshot['name'],
      phoneNumber: snapshot['phonenumber'],
      userName: snapshot['username'],
      downloadURL: snapshot['downloadURL'],
      location: snapshot['location'],
      isuserhome: snapshot['isuserhome'],
      msgs: snapshot['msgs'],
    );
  }

  Stream<Myuser?> get userData {
    return userdata.doc(uid).snapshots().map(_userDatafromsnapshot);
  }
}
