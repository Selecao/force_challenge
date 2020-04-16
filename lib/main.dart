import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'force_home_page.dart';

void main() {
  runApp(ForceChallengeApp());
}

class ForceChallengeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,

          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Helvetica',
              )),
      home: ForceHomePage(),
    );
  }
}
