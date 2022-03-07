import 'package:enos_app/screens/readfile.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _data;
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
