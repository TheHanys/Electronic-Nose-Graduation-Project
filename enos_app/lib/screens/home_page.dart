import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:enos_app/screens/readfile.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/user.dart';
import '../services/database.dart';
import '../shared/loading.dart';
import 'package:dio/dio.dart';
import '../controllers/message_controller.dart';
import '../models/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void connect() {
    IO.Socket socket = IO.io('http://192.168.1.5:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.onConnect(((msg) => print("connected")));
    socket.on("Alert", (msg) {
      // print(msg);
      socket.on('Alert', (data) => print(msg));
    });
    print(socket.connected);

    print(socket.id);
  }

  void initstate() {
    super.initState();
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alerts'),
        backgroundColor: Colors.blueGrey,
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
      body: ElevatedButton(
        onPressed: () {
          setState(() {
            connect();
          });
        },
        child: const Text('Send Message'),
      ),
    );
  }
}
