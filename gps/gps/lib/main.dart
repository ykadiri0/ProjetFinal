import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();
  final Set<Marker> markers = new Set();

  /////////////////////////////////////////
  DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin()!;


  //////////////////////////////////

  void posit(double lat,double lan)  async{

    String baseUrl = "http://voituretracker.herokuapp.com/test";
    AndroidDeviceInfo androidInfo=await deviceInfoPlugin!.androidInfo;
    try {
        var response = await http.post(Uri.parse(baseUrl),body:{"id":androidInfo!.id,"lat":lat.toString(),"long":lan.toString(),"date":DateTime.now().toString()});

      } catch (e) {
        print(e);
      }

  }





  void _onMapCreated(GoogleMapController _cntlr)
  {

    _controller = _cntlr;
     setState(() {
       markers;
     });
    _location.changeSettings(interval: 500,distanceFilter: 500);
    _location.onLocationChanged.listen((l) {
      //posit(l.latitude!, l.longitude!);
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 5),
          ),
      );
     setState(() {
       posit(l.latitude!, l.longitude!);

       markers.add(Marker( //add first marker
  markerId: MarkerId('$l.latitude!'),
  position: LatLng(l.latitude!, l.longitude!), //position of marker
  infoWindow: InfoWindow( //popup info 
    title: 'My Custom Title ',
    snippet: 'My Custom Subtitle',
  ),
  icon: BitmapDescriptor.defaultMarker, //Icon for Marker
));print(markers);
     });
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: markers
            ),
          ],
        ),
      ),
    );
  }

  
}








