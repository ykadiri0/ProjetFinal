import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterapp/transaction.dart';
import 'package:http/http.dart';
import 'cards_design.dart';
import 'student.dart';
import 'send.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
String URL="voituretracker.herokuapp.com";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}



const darkBlueColor = Color(0xff486579);

class MyAppPosition extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Flutter with Express',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Liste de Voiture'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  String imageData="";
  bool dataLoaded = false;
  Student studentService = Student();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Color.fromARGB(255, 170, 193, 232),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MakeDashboardItems()),
              );
            },
          ),
        ),
        body: Container(
          child: FutureBuilder<List>(
            future: studentService.getAllStudent(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane:  ActionPane(
                        motion: const ScrollMotion(),

                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SplashScreen2(snapshot.data![i]['numTracer'])),
                              );
                            },
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.add_location_alt ,
                            label: 'Position',
                          ),
                        ],
                      ),
                      child:Column(

                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.add_location_alt_outlined ,
                              color: darkBlueColor,
                              size: 40.0,
                            ),
                            title: Text(
                              snapshot.data![i]['marque']+"  matricule:  "+  snapshot.data![i]['matricule'],
                              style: TextStyle(color: darkBlueColor, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("  matricule:  "+  snapshot.data![i]['matricule']),
                            onTap: () {
                            },
                          ),
                          Divider(
                            height: 5.0,
                          ),
                        ],
                      ),);
                  },
                );
              } else {
                return const Center(
                  child: Text('No Data Found'),
                );
              }
            },
          ),
        ));
  }
}

class MyMap extends StatefulWidget {
  final String id;
  late double lan;
  late double lat;


  MyMap(this.id, {Key? key}) : super(key: key);





  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;
  Location _location = Location();
  final Set<Marker> markers = new Set();
  Random random = new Random();
  late String id = widget.id;
  late double lan = 100;
  late double lat = 40;
  late String date="";





  Future<double> getLocationLat(String id) async {
    String baseUrl = "http://"+URL+"/cord/$id";
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["latitude"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<double> getLocationLan(String id) async {
    String baseUrl = "http://"+URL+"/cord/$id";
    print("object");
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        date=jsonDecode(response.body)["date"].toString();
        return jsonDecode(response.body)["longitude"];
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<double> getlan(){
    return Future.delayed(const Duration(seconds: 4), () => 60);
  }

  void controlePos(String id) async {
    lan =  await getLocationLat(id);
    lat =  await getLocationLan(id);
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      markers;
    });
    _location.onLocationChanged.listen((l) async {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lan, lat),zoom: 10),
          ),
        );

        setState((){

          markers.add(Marker( //add first marker
            markerId: MarkerId('$l.latitude!'),
            position: LatLng(lan, lat), //position of marker
            infoWindow: InfoWindow( //popup info
              title: date,
              snippet: '$lan, $lat',
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ));
        });

        controlePos(id);

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 170, 193, 232),
        title: Center(
          child: Text(
            "position",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAppPosition()),
            );
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
                initialCameraPosition: CameraPosition(target: LatLng(lan, lat)),
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
