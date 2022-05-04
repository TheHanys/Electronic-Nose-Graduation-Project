// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:enos_app/shared/loading.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_launcher_icons/main.dart';
// import 'package:provider/provider.dart';
// import '../models/user.dart';
// import '../services/database.dart';

// class uploadfile extends StatelessWidget {
//   const uploadfile({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Firebase Storage'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   String? _currentname;
//   String? _currentusername;
//   String? _currentphonenumber;
//   String? _downloadURL;
//   String? userid;
//   String? _location;
//   bool? _isuserhome;
//   String? _fileURL;
//   void _addImages() {
//     var storage = FirebaseStorage.instance;

//     List<String> listOfImage = [
//       'assets/file/file.txt',
//     ];

//     listOfImage.forEach((img) async {
//       String imageName =
//           img.substring(img.lastIndexOf("/"), img.lastIndexOf("."));

//       String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

//       final Directory systemTempDir = Directory.systemTemp;
//       final byteData = await rootBundle.load(img);
//       final file = File('${systemTempDir.path}/$imageName.txt');

//       await file.writeAsBytes(byteData.buffer
//           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

//       TaskSnapshot taskSnapshot =
//           await storage.ref('$path/$imageName').putFile(file);
//       final String fileURl = await taskSnapshot.ref.getDownloadURL();
//       _fileURL = fileURl;
//       await FirebaseFirestore.instance
//           .collection('userdata')
//           .add({"url": fileURl, "name": imageName});

//       _counter++;
//       print(_counter);
//     });

//     print("Uploading finished.....");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<Myuser?>(context);
//     return StreamBuilder<Myuser?>(
//         stream: DatabaseService(uid: user!.uid).userData,
//         builder: (context, snapshot) {
//           //print(snapshot.hasData);
//           if (snapshot.hasData) {
//             Myuser userdata = snapshot.data!;

//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(widget.title),
//               ),
//               body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Text(
//                       'You are uploading the file to Firebase storage',
//                     ),
//                     Text(
//                       '$_counter',
//                       style: Theme.of(context).textTheme.headline4,
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           primary: Colors.blueGrey,
//                         ),
//                         onPressed: () async {
//                           await DatabaseService(uid: userdata.uid)
//                               .updateUserData(
//                             _currentname ?? userdata.name,
//                             _currentusername ?? userdata.userName,
//                             _currentphonenumber ?? userdata.phoneNumber,
//                             _downloadURL ?? userdata.downloadURL,
//                             _location ?? userdata.location,
//                             _isuserhome ?? userdata.isuserhome,
//                             _fileURL ?? userdata.fileURL,
//                           );
//                           if (_downloadURL == null) {
//                             const snackBarup = SnackBar(
//                               content: Text('error uploading image!'),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBarup);
//                           } else {
//                             const snackBarup = SnackBar(
//                               content: Text('image uploaded successfully!'),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBarup);
//                             Navigator.pop(context);
//                           }
//                         },
//                         child: Text('update profile picture')),
//                   ],
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: _addImages,
//                 tooltip: 'Increment',
//                 child: const Icon(Icons.add),
//               ), // This trailing comma makes auto-formatting nicer for build methods.
//             );
//           }
//           return Loading();
//         });
//   }
// }
