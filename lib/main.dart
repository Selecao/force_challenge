import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:forcechallenge/components/application/a_app.dart';
import 'package:forcechallenge/components/application/app_theme.dart';
import 'package:forcechallenge/repository/notification_repository.dart';
import 'package:forcechallenge/state/message_store.dart';
import 'force_home_page.dart';

void main() {
  runApp(ForceChallengeApp());
}

class ForceChallengeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //wrap the most top widget with multi provider
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => NotificationRepository(),
        ),
      ],
      child: AApp(
        showSemanticsDebugger: false,
        title: 'Flutter Demo',
        theme: AppThemeData(),

        /* there was ThemeData from MaterialApp:
                ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: constants.white,

            // Use the old theme but apply the following changes
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: 'Helvetica',
                ),),*/

        // wrap the next page widget with proxy provider plus Store
        home: ProxyProvider<NotificationRepository, MessageStore>(
          update: (_, notificationRepository, __) =>
              MessageStore(notificationRepository),
          child: ForceHomePage(),
        ),
      ),
    );
  }
}
