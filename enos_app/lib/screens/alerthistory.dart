import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:flutter/services.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? _data;

  Future<void> loadData() async {
    final _loadedData = await rootBundle.loadString('assets/file.txt');
    _data = _loadedData;
    print(_data);
    setState(() {
      Text(_data ?? "no leaks");
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    print(_data);
    final newdata = LineSplitter().convert(_data ?? "");
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: MyDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
              title: Text(_data ?? "no leaks"),
              leading: Icon(Icons.warning),
              trailing: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
