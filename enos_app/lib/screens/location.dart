import 'dart:ffi';

import 'package:enos_app/models/user.dart';
import 'package:enos_app/screens/home_page.dart';
import 'package:enos_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class location extends StatefulWidget {
  // location
  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  var locationMessage = '';
  String? latitude;
  String? longitude;
  String? _currentname;
  String? _currentusername;
  String? _currentphonenumber;
  String? _downloadURL;
  String? userid;
  bool? _isuserhome;
  String? _location;
  String? _fileURL;
  List? _msgs;

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    setState(() {
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }

  // function for opening it in google maps

  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    print(googleUrl);
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else
      throw ("Couldn't open google maps");
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Myuser?>(context);
    return StreamBuilder<Myuser?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          //print(snapshot.hasData);
          if (snapshot.hasData) {
            Myuser userdata = snapshot.data!;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'User location application',
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Scaffold(
                backgroundColor: Colors.blueGrey,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 45.0,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Get User Location",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        locationMessage,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          getCurrentLocation();
                        },
                        child: Text("Get your Location"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          primary: Colors.blue,
                        ),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                          _location = "$longitude, $latitude";
                          await DatabaseService(uid: userdata.uid)
                              .updateUserData(
                            _currentname ?? userdata.name,
                            _currentusername ?? userdata.userName,
                            _currentphonenumber ?? userdata.phoneNumber,
                            _downloadURL ?? userdata.downloadURL,
                            _location ?? userdata.location,
                            _isuserhome ?? userdata.isuserhome,
                            _msgs ?? userdata.msgs,
                            //  _fileURL ?? userdata.fileURL,
                          );
                        },
                        child: Text("Confirm location"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
