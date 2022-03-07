import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class readfile extends StatefulWidget {
  const readfile({Key? key}) : super(key: key);

  @override
  _readfileState createState() => _readfileState();
}

class _readfileState extends State<readfile> {
  String? _data;

  // This function is triggered when the user presses the floating button
  Future<void> loadData() async {
    final _loadedData = await rootBundle.loadString('assets/file.txt');
    setState(() {
      _data = _loadedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('alerts'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: loadData, child: const Icon(Icons.call)),
    );
  }
}
