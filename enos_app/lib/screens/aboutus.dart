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
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                'Enose',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 70,
              ),
              Text(
                'Our proposed system aims to assist Anosmic people, by helping them recognize whether the place they occupy is safe or not; that with taking into consideration many aspects, starting from life-threatening situations that could be fatal, going through subjects that could threaten their health, and finally making sure they are in a safe surrounding free of any harmful-inhaled substances. To begin utilizing our services please connect the device to the electronic nose, and begin recording the detections detected by the electronic nose.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Text("For any issues contact omarbaadry@gmail.com"),
            ],
          ),
        ));
  }
}
