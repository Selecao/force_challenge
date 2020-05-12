import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:forcechallenge/state/message_store.dart';
import 'force_home_page.dart';
import 'constants.dart' as constants;

void main() {
  runApp(ForceChallengeApp());
}

class ForceChallengeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: constants.white,

          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Helvetica',
              )),

      // wrap the top widget with provider
      home: Provider(
        create: (_) => MessageStore(),
        child: ForceHomePage(),
      ),
    );
  }
}
