import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/position.dart';
import 'cards_design.dart';
import 'main.dart';
import 'models/contact.dart';
import 'package:http/http.dart' as http;
String a=" ";
String action="a";
String urlv="http://"+URL+"/gettvoiture";
class MyAppv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracer  App',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),
      home: MyHomePage(title:'Voiture List'),
    );
  }
}

const darkBlueColor = Color(0xff486579);

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Contact _contact = Contact('');
  List<Contact> _contacts = [];
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  bool y = false;
  int t = 0;
  String y3 = "";
  bool checkedValue = false;
  bool checkedValue2 = false;
  bool newValue = true;
  bool newValue2 = true;
  void f() {
    y = true;
  }
  Future<List> getAllvoiture() async {
    try {
      var response = await http.get(Uri.parse("http://"+URL+"/sendvoiteur"));
      print("hello");
      if (response.statusCode == 200) {
        //print(response.body);
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 170, 193, 232),
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(color: darkBlueColor),
          ),
        ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  _form() => Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'matricule'),
            controller: myController,
            onSaved: (val) => setState(() => _contact.name = val!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'type'),
            controller: myController2,
            onSaved: (val) => setState(() => _contact.name = val!),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'marque'),
            controller: myController3,
            onSaved: (val) => setState(() => _contact.name = val!),
          ),
          TextButton(
            style: ButtonStyle(

            ),
            onPressed: ()async{
              try {
                if(action=="a"){
                  var response =  http.post(Uri.parse(urlv),body:{"action":action,"matricule":myController.text,"type":myController2.text,"marque":myController3.text});

                }
                else{
                  var response =  http.post(Uri.parse(urlv),body:{"action":action,"matricule":myController.text,"type":myController2.text,"marque":myController3.text,"_id":a});
                }

                action="a";
                a="";
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppv()),
                );
                setState(() {

                });
              } catch (e) {
                print(e);
              } },
            child: Text('Save'),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
          ),
        ],
      ),
    ),
  );
  _onSubmit() async {
    if (y == false) {
      var form = _formKey.currentState;
      form?.save();
      print('''
      Name : ${_contact.name}
      ''');
      _contacts.add(Contact(_contact.name));
      form?.reset();
      myController.text = "";
      myController2.text = "";
    } else {
      var form = _formKey.currentState;

      form?.save();

      _contacts[t].name = myController.text;
      y = false;
      myController.text = "";
    }
  }

  _list() => Expanded(
    child: FutureBuilder<List>(
      future: getAllvoiture(),
      builder: (context, snapshot) {
        print("/////////)");
        print(snapshot.data);
        print("/////////)");
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, i) {
              return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async{
                        try {
                          var response = await http.post(Uri.parse(urlv),body:{"action":"d","_id":snapshot.data![i]["_id"]});
                          setState(() {
                            _contact.getAllStudent();
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.car_crash_outlined,
                        color: darkBlueColor,
                        size: 40.0,
                      ),
                      title: Text("Matricule:  "+snapshot.data![i]["matricule"]/*
                             ,
                                /*"  matricule:  " +
                                snapshot.data![i]['num'],*/
                            style: TextStyle(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold),*/
                      ),
                      subtitle: Text("Marque: "+  snapshot.data![i]['marque'] +"  " +"Type: "+ snapshot.data![i]['type']),
                      onTap: () {
                        myController.text=snapshot.data![i]['matricule'];
                        myController2.text=snapshot.data![i]['type'];
                        myController3.text=snapshot.data![i]['marque'];
                        a=snapshot.data![i]['_id'];
                        action="u";
                      },
                    ),
                    Divider(
                      height: 5.0,
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No Data Found'),
          );
        }
      },
    ),
  );
}
