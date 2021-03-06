import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// https://medium.com/@kashifmin/flutter-login-app-using-rest-api-and-sqflite-b4815aed2149
final BASE_URL_GET =
    "http://hoctienganhphanxa.com/api/p4akhairapp/Controller/GetAllByWhat.php";
final BASE_URL_POST =
    "http://hoctienganhphanxa.com/api/p4akhairapp/Controller/GetAllByWhat.php";
final _API_KEY = "somerandomkey";

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(input) {
    String url = BASE_URL_GET + '?input=' + input;

    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post({Map headers, body, encoding}) {
    String url = BASE_URL_POST;

    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}

