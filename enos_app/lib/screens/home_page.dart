import 'package:enos_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:enos_app/drawer/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MessageModel> messages = [];
  var Alert = "";
  List<String> Alerts = [];

  IO.Socket socket = IO.io('http://192.168.1.4:5000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  connect() async {
    socket.connect();
    //print("connected");
    print(socket.id);
    print(socket.connected);
  }

  void RecweiveMsg() {
    socket.onConnect((msg) {
      socket.on("Alert", (msg) {
        print(msg);
        Alert = msg;
        Alerts.add(msg);
      });
    });
  }

  get onDidRecieveLocalNotification => null;

  get onSelectNotification => null;
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics =
        AndroidNotificationDetails('100', 'DLite');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    if (Alerts.isNotEmpty) {
      await flutterLocalNotificationsPlugin.show(
          100, "Enose Alert", Alert, platformChannelSpecifics);
      print("((alerts list isn't empty))");
      print(Alerts.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    connect();
    //setState(() {
    RecweiveMsg();
    _showNotification();
    //});

    return Scaffold(
        appBar: AppBar(
          title: Text('Alerts'),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                launch("tel:122");
              },
            )
          ],
        ),
        drawer: MyDrawer(),
        body: ListView.builder(
            itemCount: Alerts.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    //                    <-- BoxDecoration
                    border: Border(bottom: BorderSide(), right: BorderSide()),
                  ),
                  child: ListTile(
                    title: Text('${Alerts[index]}'),
                  ));
            }));
  }
}
