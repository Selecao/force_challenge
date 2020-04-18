import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'constants.dart' as constants;
import 'package:forcechallenge/state/message_store.dart';
import 'widgets/networking_page_header.dart';
import 'package:forcechallenge/widgets/messages_items_view.dart';

class ForceHomePage extends StatefulWidget {
  @override
  _ForceHomePageState createState() => _ForceHomePageState();
}

class _ForceHomePageState extends State<ForceHomePage> {
  MessageStore _messageStore;
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _messageStore ??= Provider.of<MessageStore>(context);
    _disposers ??= [
      reaction(
        (_) => _messageStore.errorMessage,
        (String message) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

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
          MessageItemsView(_messageStore),
          /*
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
          /*SliverFillRemaining(
            child: Center(
              child: Text(
                'Это все уведомления!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
