import 'dart:ffi';

class Myuser {
  final String? uid;
  final String? name;
  final String? password;
  final String? email;
  final String? userName;
  final String? phoneNumber;
  final String? downloadURL;
  final String? location;
  bool? isuserhome;
  //final String fileURL;
  final List? msgs;
  Myuser({
    this.uid,
    this.name,
    this.password,
    this.email,
    this.userName,
    this.phoneNumber,
    this.downloadURL,
    this.location,
    this.isuserhome,
    this.msgs,
    //   this.fileURL = '',
  });
}
