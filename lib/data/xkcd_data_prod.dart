import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttermvpillustrativeapp/data/xkcd_data.dart';

class ProdXKCDRepo implements XKCDRepo {
  String baseURL = "http://xkcd.com/";

  @override
  Future<List<XKCD>> fetchComicPost() async {
    http.Response response = await http.get(baseURL + "info.0.json");
    final List responseBody = jsonDecode(response.body);
    final statusCode = response.statusCode;

    if (statusCode != 200 || response.body == null) {
      throw new FetchDataException("An error occured while fetching data: [Status Code: $statusCode]");
    }
    return responseBody.map((c) => XKCD.fromMap(c)).toList();
  }
}