library message;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:forcechallenge/models/serializers.dart';

part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  Message._();

  factory Message([updates(MessageBuilder b)]) = _$Message;

  @BuiltValueField(wireName: 'unread')
  bool get unread;
  @BuiltValueField(wireName: 'text')
  String get text;
  @BuiltValueField(wireName: 'img')
  String get img;
  @BuiltValueField(wireName: 'price')
  int get price;

  String toJson() {
    return json.encode(serializers.serializeWith(Message.serializer, this));
  }

  static Message fromJson(String jsonString) {
    return serializers.deserializeWith(
        Message.serializer, json.decode(jsonString));
  }

  static Serializer<Message> get serializer => _$messageSerializer;
}
