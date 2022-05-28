import 'dart:ffi';

import 'package:enos_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:enos_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  Myuser? _userFromFirebaseUser(User user) {
    return user != null ? Myuser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Myuser> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!)!);
  }

  //sign in with email and password
  Future signin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future register(
    String name,
    String password,
    String email,
    String username,
    String phonenumber,
    String downloadURL,
    String location,
    bool? isuserhome,
    List? msgs,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(
          name, username, phonenumber, downloadURL, location, isuserhome, msgs);
      print(user.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error signingout');
      print(e.toString());
    }
  }
}
