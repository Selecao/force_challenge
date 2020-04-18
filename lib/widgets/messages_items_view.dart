import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:built_collection/built_collection.dart';

import 'package:forcechallenge/state/message_store.dart';
import 'package:forcechallenge/models/message.dart';
import 'package:forcechallenge/widgets/avatar.dart';
import 'package:forcechallenge/widgets/text_and_button.dart';
import 'package:forcechallenge/constants.dart' as constants;

class MessageItemsView extends StatelessWidget {
  const MessageItemsView(this.messageStore);

  final MessageStore messageStore;

  @override
  Widget build(BuildContext context) => Observer(
        // ignore: missing_return
        builder: (_) {
          switch (messageStore.state) {
            case StoreState.initial:
              return buildInitialInput();

            case StoreState.loading:
              return buildLoading();

            case StoreState.loaded:
              return SliverFillRemaining(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: CustomScrollView(
                    primary: true,
                    slivers: [
                      TextSliver(text: 'Последние'),
                      MessageSliverListWidget(
                        backgroundColor: constants.greyLight,
                        messageList: messageStore.unreadMessages,
                      ),
                      TextSliver(text: 'Ранее'),
                      MessageSliverListWidget(
                        backgroundColor: null,
                        messageList: messageStore.readMessages,
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      );

  Widget buildInitialInput() {
    return SliverToBoxAdapter(
      child: TextAndButton(
        content: """
              <h3><center>Вы впервые?</center></h3>
              <center>Это очень важное сообщение. Пожалуйста, нажмите на кнопку ниже.</center>
              """,
        buttonText: 'Загрузить уведомления',
        onPressed: _refresh,
      ),
    );
  }

  Widget buildLoading() {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Text('Загрузка сообщений...'),
          ],
        ),
      ),
    );
  }

  Widget buildMessages() {
    return MessageSliverListWidget(
      backgroundColor: constants.greyLight,
      messageList: messageStore.unreadMessages,
    );
  }

  Future _refresh() => messageStore.fetchMessages();
}

class TextSliver extends StatelessWidget {
  const TextSliver({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '$text',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class MessageSliverListWidget extends StatelessWidget {
  MessageSliverListWidget({this.backgroundColor, this.messageList});
  final BuiltList<Message> messageList;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 78,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    //borderRadius: constants.framesRadius,
                    color: backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Avatar(
                        radius: 20,
                        photoUrl: messageList[index].img,
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Html(
                          data: "${messageList[index].text}",
                          useRichText: true,
                          //shrinkToFit: false,
                        ),
                      ),
                      if (messageList[index].price != 0)
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              "-${messageList[index].price} ₽",
                              style: constants.defaultTextStyle.copyWith(
                                color: Color(0xFF00A072),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (index != (messageList.length - 1))
                  Divider(
                    height: 0.0,
                    thickness: 1.0,
                    color: constants.greySeparator,
                  ),
              ],
            ),
          );
        },
        childCount: messageList.length,
      ),
    );
  }
}

/// ********
abstract class ListMessage {
  bool unread;

  Widget buildUnread(BuildContext context);

  Widget buildRead(BuildContext context);
}

/// *******
class UnreadItem implements ListMessage {
  bool unread;

  UnreadItem(this.unread);

  Widget buildUnread(BuildContext context) {
    if (unread) {
      return Text(
        "is not read yet",
        style: Theme.of(context).textTheme.headline5,
      );
    }
  }

  Widget buildRead(BuildContext context) {
    if (!unread) {
      return Text(
        'already read',
        style: Theme.of(context).textTheme.headline5,
      );
    }
  }
}
