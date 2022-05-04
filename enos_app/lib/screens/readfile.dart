/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class readfile extends StatefulWidget {
  const readfile({Key? key}) : super(key: key);

  @override
  _readfileState createState() => _readfileState();
}

class _readfileState extends State<readfile> {
  String? _data;

  // This function is triggered when the user presses the floating button
  //Future<void> loadData() async {
  //final _loadedData = await rootBundle.loadString('assets/file.txt');
  //setState(() {
  // _data = _loadedData;
  // });
  // }

  void readData() {
    var lines = File('assets/file.txt').readAsLinesSync();
    lines.removeAt(0);

    for (var line in lines) {
      final value = line.split(';');
      _data = value[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    //loadData();
    readData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('alerts'),
      ),
      body: Center(
          child: SizedBox(width: 300, child: Text(_data ?? 'Nothing to show'))),
    );
  }
}
*/