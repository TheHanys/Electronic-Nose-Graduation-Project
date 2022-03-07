import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts History'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
              title: Text("GAS LEAK DETECTED"),
              subtitle: Text("20/2/2022"),
              leading: Icon(Icons.warning),
              trailing: Icon(Icons.delete)),
          ListTile(
              title: Text("GAS LEAK DETECTED"),
              subtitle: Text("20/2/2022"),
              leading: Icon(Icons.warning),
              trailing: Icon(Icons.delete)),
          ListTile(
              title: Text("GAS LEAK DETECTED"),
              subtitle: Text("20/2/2022"),
              leading: Icon(Icons.warning),
              trailing: Icon(Icons.delete)),
        ],
      ),
    );
  }
}
