library message;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:forcechallenge/models/serializers.dart';

part 'notification.g.dart';

abstract class Notification
    implements Built<Notification, NotificationBuilder> {
  Notification._();

  factory Notification([updates(NotificationBuilder b)]) = _$Notification;

  @BuiltValueField(wireName: 'unread')
  bool get unread;

  @BuiltValueField(wireName: 'text')
  @nullable
  String get text;

  @BuiltValueField(wireName: 'img')
  @nullable
  String get img;

  @nullable
  @BuiltValueField(wireName: 'price')
  int get price;

  String toJson() {
    return json
        .encode(serializers.serializeWith(Notification.serializer, this));
  }

  static Notification fromJson(String jsonString) {
    return serializers.deserializeWith(
        Notification.serializer, json.decode(jsonString));
  }

  static Serializer<Notification> get serializer => _$notificationSerializer;
}
