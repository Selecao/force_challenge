import 'package:dio/dio.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    var dio = Dio();
    Response response = await dio.get(url);
    print(response.data);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return jsonDecode(response.data);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Response');
    }
  }
}
