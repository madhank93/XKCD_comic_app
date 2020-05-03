import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';

class ProdXKCDRepo {
  String baseURL = "http://xkcd.com/";

  Future<XKCD> fetchComicPost() async {
    http.Response response = await http.get(baseURL + "info.0.json");
    final responseBody = json.decode(response.body);
    final statusCode = response.statusCode;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return XKCD.fromJson(json.decode(response.body));
    }
  }

  Future<XKCD> fetchComicPostURL(int count) async {
    http.Response response = await http.get(baseURL+count.toString()+"/"+"info.0.json");
    final responseBody = json.decode(response.body);
    final statusCode = response.statusCode;

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(XKCD.fromJson(json.decode(response.body)).imageURL);
      return XKCD.fromJson(json.decode(response.body));
    }
  }
}