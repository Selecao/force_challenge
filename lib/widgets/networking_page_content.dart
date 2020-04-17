import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:built_collection/built_collection.dart';

import 'package:forcechallenge/models/message.dart';
import 'package:forcechallenge/services/networking.dart';
import 'package:forcechallenge/widgets/avatar.dart';
import 'package:forcechallenge/widgets/text_and_button.dart';

import 'package:forcechallenge/constants.dart' as constants;

class NetworkingPageContent extends StatefulWidget {
  @override
  _NetworkingPageContentState createState() => _NetworkingPageContentState();
}

class _NetworkingPageContentState extends State<NetworkingPageContent> {
  bool _isFirstLoad = true;
  Future<BuiltList<Message>> _loader;

  Future<BuiltList<Message>> getData() async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://www.mocky.io/v2/5e85a947300000290097b2b4?mocky-delay=2000ms');

    var messageData = await networkHelper.getData();

    return messageData;
  }

  void _retry() {
    // update loader
    _loader = getData();
  }

  void _firstLoadComplete() {
    setState(() => _isFirstLoad = !_isFirstLoad);
  }

  @override
  void initState() {
    super.initState();
    _loader = getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BuiltList<Message>>(
      future: _loader,
      builder: (context, snapshot) {
        if (_isFirstLoad) {
          return SliverToBoxAdapter(
            child: TextAndButton(
              content: """
              <h3><center>Вы впервые?</center></h3>
              <center>Это очень важное сообщение. Пожалуйста, нажмите на кнопку ниже.</center>
              """,
              buttonText: 'Загрузить уведомления',
              onPressed: _firstLoadComplete,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: TextAndButton(
              content: "<h5><center>Что-то пошло не так.</center></h5>",
              buttonText: 'Обновить',
              onPressed: _retry,
            ),
          );
        }

        if (snapshot.hasData) {
          final messageList = snapshot.data;
          final messagesUnread = BuiltList<Message>.from(
              messageList.where((message) => message.unread));
          final messagesRead = BuiltList<Message>.from(
              messageList.where((message) => !message.unread));

          return MessageSliverListWidget(
            backgroundColor: constants.greyLight,
            messageList: messagesUnread,
          );
        }

        return SliverFillRemaining(
          child: Center(child: Text('Это все уведомления!')),
        );
        /*SliverToBoxAdapter(
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
            MessageSliverListWidget(
              backgroundColor: constants.greyLight,
              messageList: BuiltList<Message>.from(
                  snapshot.data.where((message) => message.unread)),
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
            MessageSliverListWidget(
              backgroundColor: constants.greyLight,
              messageList: BuiltList<Message>.from(
                  snapshot.data.where((message) => !message.unread)),
            ),*/
      },
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
