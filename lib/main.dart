

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double latData ;
  double longData ;
  String add1;
  String add2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async{
    final getPosition = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latData = getPosition.latitude;
      longData = getPosition.longitude;
    });
    getAddressBasedOnLocation();
  }

  getAddressBasedOnLocation() async{
    final coordinates = await Coordinates(latData, longData);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      add1 = address.first.countryName;
      add2 = address.first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text("$add1"),
            Text("$add2"),
          ],
        ),
      ),
    );
  }
}
