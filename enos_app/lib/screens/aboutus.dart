import 'package:flutter/material.dart';

class aboutus extends StatefulWidget {
  @override
  _aboutus createState() => _aboutus();
}

class _aboutus extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About us '),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/images/enose.png',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ENose',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Developed by MIU Students',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'To begin utilizing our services please connect the device to the electronic nose, and begin recording the detections detected by the electronic nose.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
