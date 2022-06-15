import 'dart:convert';
import 'package:flutterapp/position.dart';
import 'package:http/http.dart' as http;

class LocationDB {
  Future<double> getLocationLat(String id) async {
    String baseUrl = "http://"+URL+"/$id";
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return double.parse(jsonDecode(response.body)["lat"]);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}