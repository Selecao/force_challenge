import 'package:flutter/cupertino.dart';
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

const Color white = Color(0xFFFFFFFF);

const Color greyLight = Color(0xFFEDF4F8);

const Color buttonColor = Color(0xFF2E5BF5);

const Color greySeparator = Color.fromRGBO(135, 152, 173, 0.3);

final BorderRadius framesRadius = BorderRadius.circular(12.0);

final BoxShadow boxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  blurRadius: 2.0, // has the effect of softening the shadow
  spreadRadius: 0.0, // has the effect of extending the shadow
  offset: Offset(
    2.0, // horizontal, move right
    4.0, // vertical, move down
  ),
);
