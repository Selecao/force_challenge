import 'package:flutter/material.dart';

final TextStyle boldTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
);

final TextStyle boldDarkTextStyle = boldTextStyle.copyWith(color: Colors.black);

final TextStyle defaultTextStyle =
    TextStyle(fontSize: 14.0, color: Colors.white);

final TextStyle defaultDarkTextStyle =
    defaultTextStyle.copyWith(color: Colors.black);

final Color backgroundLight = Color(0xFFEDF4F8);

final Color buttonColor = Color(0xFF2E5BF5);

final BorderRadius framesRadius = BorderRadius.circular(12.0);

final BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  blurRadius: 2.0, // has the effect of softening the shadow
  spreadRadius: 0.0, // has the effect of extending the shadow
  offset: Offset(
    2.0, // horizontal, move right 10
    4.0, // vertical, move down 10
  ),
);
