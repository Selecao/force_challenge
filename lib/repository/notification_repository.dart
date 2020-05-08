import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// *************************************************************************
// If you use dio in flutter development,
// you'd better to decode json in background with [compute] function.
// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
// *************************************************************************

// Repository - в принципе общепринятое название для того, что работает с сетью или БД

class NotificationRepository {
  NotificationRepository(this.url);

  final String url;

  Future getData() async {
    var _dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );

    //Custom jsonDecodeCallback for flutter development ********************
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    Response response = await _dio.get(url);
    print("JSON: \n ${response.data}");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse (deserialize) json.
      //BuiltList<Message> messageList = _handleListResponse<Message>(response);

      //return messageList;
      return response;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Response');
    }
  }
}
