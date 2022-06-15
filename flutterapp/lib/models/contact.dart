import 'package:http/http.dart' as http;
import 'dart:convert';

import '../position.dart';
String baseUrl1 = "http://"+URL+"/gettracerss";
class Contact {
  static int count=0;
  int id=0;
  String name="";
  Contact(name){
    this.name=name;
  }

  Future<List> getAllStudent() async {
    try {
      var response = await http.get(Uri.parse("http://"+URL+"/sendtracers"));
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
}