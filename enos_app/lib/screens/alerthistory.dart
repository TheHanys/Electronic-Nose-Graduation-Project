import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:enos_app/screens/readfile.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? _data;

  Future<void> loadData() async {
    final _loadedData = await rootBundle.loadString('assets/file.txt');
    // LineSplitter.split(_data!).forEach((line) => print('$line'));
    _data = _loadedData;
    print(_data);
    setState(() {
      Text(_data ?? "no leaks");
    });
  }
  // Future<void> loadData() async {
  //   final _loadedData = await rootBundle.loadString('assets/file.txt');
  //   setState(() {
  //     _data = _loadedData;
  //   });
  // }

  // Future<void> uploadExample() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String filePath = 'C:\\Users\\dell\\OneDrive\\Desktop\\tete.txt';
  //   // ...
  //   await uploadFile(filePath);
  // }

  // Future<void> uploadFile(String filePath) async {
  //   File file = File(filePath);
  //   print(file);

  //   try {
  //     await FirebaseStorage.instance.ref().putFile(file);
  //     print('zzz');
  //   } on firebase_core.FirebaseException catch (e) {
  //     e.code == 'canceled';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // uploadExample();
    loadData();
    print(_data);
    final newdata = LineSplitter().convert(_data ?? "");
    // for (var i = 0; i < newdata.length; i++) {
    //   setState(() {
    //     Text(newdata[i]);
    //     print('$i: ${newdata[i]}');
    //   });
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: () {
              launch("tel:122");
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
              title: Text(_data ?? "no leaks"),
              subtitle: Text("8/3/2022"),
              leading: Icon(Icons.warning),
              trailing: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
