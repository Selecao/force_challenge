import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:forcechallenge/widgets/message_sliver_list.dart';
import 'package:forcechallenge/widgets/page_sliver_header.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:forcechallenge/constants.dart' as constants;
import 'package:forcechallenge/state/message_store.dart';

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

    // disposers for error messages
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
      body: Observer(
        builder: (_) {
          switch (_messageStore.status) {
            case FutureStatus.pending:
              return buildLoading();
            case FutureStatus.fulfilled:
              return buildLoaded();
            default:
              return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() {
    return CustomScrollView(slivers: [
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: PageSliverHeader(
          minExtent: 100.0,
          maxExtent: 250.0,
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40.0),
                decoration: BoxDecoration(
                  color: constants.greyLight,
                  borderRadius: constants.framesRadius,
                  boxShadow: [
                    constants.boxShadow,
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        'Вы впервые?',
                        style: constants.boldTextStyle,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Это очень важное сообщение. Пожалуйста, нажмите на кнопку ниже.',
                        textAlign: TextAlign.center,
                        style: constants.defaultDarkTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: constants.buttonColor,
                      padding: const EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: constants.framesRadius,
                      ),
                      child: Text(
                        'Загрузить уведомления',
                        style: constants.defaultTextStyle,
                      ),
                      onPressed: _refresh,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildLoading() {
    return CustomScrollView(slivers: [
      SliverPersistentHeader(
        pinned: true,
        floating: true,
        delegate: PageSliverHeader(
          minExtent: 100.0,
          maxExtent: 250.0,
        ),
      ),
      SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Загрузка сообщений...'),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget buildLoaded() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: PageSliverHeader(
              minExtent: 100.0,
              maxExtent: 250.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Последние',
                style: constants.notificationTitleTextStyle,
              ),
            ),
          ),
          MessageSliverList(
            backgroundColor: constants.greyLight,
            notificationList: _messageStore.unreadMessages,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ранее',
                style: constants.notificationTitleTextStyle,
              ),
            ),
          ),
          MessageSliverList(
            backgroundColor: null,
            notificationList: _messageStore.readMessages,
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Это все сообщения!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _refresh() => _messageStore.fetchMessages();
}
