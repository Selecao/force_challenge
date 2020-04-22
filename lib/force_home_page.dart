import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'package:forcechallenge/state/message_store.dart';
import 'widgets/page_sliver_header.dart';
import 'package:forcechallenge/widgets/message_items_view.dart';

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
      body: MessageItemsView(_messageStore),
    );
  }
}
