import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterapp/position.dart';
import 'cards_design.dart';
import 'main.dart';
import 'models/contact.dart';
import 'package:http/http.dart' as http;
String a=" ";
String action="a";

class MyAppp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracer  App',
      theme: ThemeData(
        primaryColor: darkBlueColor,
      ),
      home: MyHomePage(title:'Tracer  List'),
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
                decoration: InputDecoration(labelText: 'Num'),
                controller: myController,
                onSaved: (val) => setState(() => _contact.name = val!),
              ),
              TextButton(
                style: ButtonStyle(

                ),
                onPressed: ()async{
                  try {
                    if(action=="a"){
                      var response =  http.post(Uri.parse("http://"+URL+"/gettracerss"),body:{"action":action,"num":myController.text});

                    }
                    else{
                    var response =  http.post(Uri.parse("http://"+URL+"/gettracerss"),body:{"action":action,"num":myController.text,"_id":a});
                    }

                    action="a";
                    a="";
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAppp()),
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
          future: _contact.getAllStudent(),
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
                              var response = await http.post(Uri.parse(baseUrl1),body:{"action":"d","num":snapshot.data![i]["num"]});
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
                            Icons.ad_units_sharp,
                            color: darkBlueColor,
                            size: 40.0,
                          ),
                          title: Text("Num:  "+snapshot.data![i]["num"]/*
                             ,
                                /*"  matricule:  " +
                                snapshot.data![i]['num'],*/
                            style: TextStyle(
                                color: darkBlueColor,
                                fontWeight: FontWeight.bold),*/
                          ),
                          subtitle: Text("id: "+  snapshot.data![i]['_id']),
                          onTap: () {
                            myController.text=snapshot.data![i]['num'];
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
