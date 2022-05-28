import 'package:enos_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../services/database.dart';
import 'package:enos_app/models/user.dart';
import 'package:enos_app/services/database.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Myuser? user = Provider.of<Myuser?>(context);
    return StreamBuilder<Myuser?>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            return Scaffold(
                appBar: AppBar(
                  title: Text('Alerts History'),
                  backgroundColor: Colors.blueGrey,
                ),
                drawer: MyDrawer(),
                body: ListView.builder(
                    itemCount: userdata.msgs!.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide()),
                          ),
                          child: Card(
                              child: ListTile(
                            leading: Icon(Icons.warning_outlined),
                            title: Text(userdata.msgs![index]),
                          )));
                    }));
          }
          return Loading();
        });
  }
}
