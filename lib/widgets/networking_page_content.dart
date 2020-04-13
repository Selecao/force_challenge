import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;

import 'package:flutter_html/flutter_html.dart';

import 'package:forcechallenge/models/message.dart';
import 'package:forcechallenge/services/networking.dart';
import 'package:forcechallenge/widgets/avatar.dart';

import 'package:forcechallenge/constants.dart' as constants;

class NetworkingPageContent extends StatefulWidget {
  @override
  _NetworkingPageContentState createState() => _NetworkingPageContentState();
}

class _NetworkingPageContentState extends State<NetworkingPageContent> {
  int _newMessageCounter = 0;
  Message message = Message(
    unread: true,
    text: "Оплата за услугу <b><u>поиск объекта</u></b>",
    imageUrl: "https://picsum.photos/201/201",
    price: 2500,
  );
  bool _isFirstLoad = true;
  Future<Message> _loader;
  bool _shouldFail = false;

  // mock function to load some data or fail after some delay
  Future<Message> getData() async {
    /*NetworkHelper networkHelper = NetworkHelper(
        'http://www.mocky.io/v2/5e85a947300000290097b2b4?mocky-delay=2000ms');

    var messageData = await networkHelper.getData();

    return messageData;*/

    await Future<void>.delayed(Duration(seconds: 3));
    if (_shouldFail) {
      throw PlatformException(code: '404');
    }
    return message;
  }

  void _updateUI([dynamic messageData]) {
    setState(() {
      /*if (messageData == null) {
        unread = false;
        text = 'Error getting message data';
        imageUrl = '';
        price = 0;
        return;
      }*/

      var unread = messageData['unread'];
      if (unread) {
        _newMessageCounter++;
      }

      var text = messageData['text'];

      var imageUrl = messageData['img'];

      var price = messageData['price'];

      var message =
          Message(unread: unread, imageUrl: imageUrl, text: text, price: price);
    });
  }

  void _retry() {
    // update loader
    _loader = getData();
    setState(() => _shouldFail = !_shouldFail);
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
    return FutureBuilder<Message>(
      future: _loader,
      builder: (context, snapshot) {
        if (_isFirstLoad) {
          return SliverToBoxAdapter(
            child: TextAndButton(
              content: """
              <h5><center>Вы впервые?</center></h5>
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
              content: """
              <h5><center>Что-то пошло не так.</center></h5>
              """,
              buttonText: 'Обновить',
              onPressed: _retry,
            ),
          );
        }
        if (snapshot.hasData) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    height: 78,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.orange[100 * (index % 7)],
                      //color: constants.backgroundLight,
                      borderRadius: constants.framesRadius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Avatar(
                          radius: 15,
                          photoUrl: snapshot.data.imageUrl,
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: Html(
                            data: """
                            ${snapshot.data.text}
                            """,
                          ),
                        ),
                        if (snapshot.data.price != 0)
                          Text(
                            "-${snapshot.data.price} ₽",
                            style: constants.defaultTextStyle
                                .copyWith(color: Color(0xFF00A072)),
                          ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 7,
            ),
          );
        }
        return SliverFillRemaining(
          child: Center(child: Text('Это все уведомления!')),
        );
      },
    );
  }
}

class TextAndButton extends StatelessWidget {
  const TextAndButton({Key key, this.content, this.buttonText, this.onPressed})
      : super(key: key);
  final String content;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: constants.backgroundLight,
              borderRadius: constants.framesRadius,
              boxShadow: [
                constants.boxShadow,
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Html(
                data: """
                $content
                """,
                onLinkTap: (url) {
                  print("Opening $url...");
                },
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FlatButton(
                    color: constants.buttonColor,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: constants.framesRadius,
                    ),
                    child: Text(buttonText, style: constants.defaultTextStyle),
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
