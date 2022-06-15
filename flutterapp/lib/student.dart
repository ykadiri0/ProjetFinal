import 'dart:convert';
import 'package:flutterapp/position.dart';
import 'package:http/http.dart' as http;

class Student {
  String baseUrl = "http://"+URL+"/sendvoiteur";
  Future<List> getAllStudent() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      print("hello");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
