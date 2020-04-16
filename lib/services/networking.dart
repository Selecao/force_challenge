import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter/foundation.dart';

import 'package:forcechallenge/models/serializers.dart';
import 'package:forcechallenge/models/message.dart';

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

class NetworkHelper {
  NetworkHelper(this.url);

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

      final dataList = response.data;

      BuiltList<Message> responses = BuiltList<Message>(dataList.map((item) {
        return serializers.deserializeWith<Message>(
            serializers.serializerForType(Message), item);
      }).toList());

      print(responses);
      return responses;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Response');
    }
  }

  // if response from server is Iterable then use this function:
  BuiltList<T> _handleListResponse<T>(Response response) {
    if (response.data == null) {
      return BuiltList<T>();
    }
    var rawList = (response.data as List<dynamic>);
    return BuiltList<T>(rawList.map((item) {
      if (T is String) {
        return item;
      } else {
        return serializers.deserializeWith<T>(
            serializers.serializerForType(T), item);
      }
    }).toList());
  }

/*
  // if response just an object use this:
  T _handleResponse<T>(Response response) {
    if (T is String) {
      return response.data;
    } else if (typeOf<void>() == T) {
      return null;
    }
    return serializers.deserializeWith(
        serializers.serializerForType(T), response.data);
  }
*/
}
