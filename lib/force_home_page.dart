import 'package:flutter/material.dart';

//import 'constants.dart' as constants;
import 'widgets/networking_page_content.dart';
import 'widgets/networking_page_header.dart';

class ForceHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: NetworkingPageHeader(
              minExtent: 100.0,
              maxExtent: 250.0,
            ),
          ),
          NetworkingPageContent(),
          /*SliverToBoxAdapter(
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
          ),*/
        ],
      ),
    );
  }
}
