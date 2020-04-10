import 'package:flutter/material.dart';

import 'constants.dart' as constants;
import 'widgets/custom_sliver_message.dart';

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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.amber,
        ),
      ),
      home: ForceHomePage(title: 'Force Page'),
    );
  }
}

class ForceHomePage extends StatefulWidget {
  ForceHomePage({this.title});

  final String title;

  @override
  _ForceHomePageState createState() => _ForceHomePageState();
}

class _ForceHomePageState extends State<ForceHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('FORCE TEST', style: TextStyle(fontSize: 14)),
            ),
          ),
          CustomSliverMessage(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FlatButton(
                  color: constants.buttonColor,
                  padding: const EdgeInsets.all(12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: constants.framesRadius,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Загрузить уведомления',
                    style: constants.defaultTextStyle,
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Последние',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.orange[100 * (index % 9)],
                  child: Text(
                    'orange $index',
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
              childCount: 9,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ранее',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('List Item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
