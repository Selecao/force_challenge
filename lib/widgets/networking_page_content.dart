import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';

import 'package:forcechallenge/models/message.dart';
import 'package:forcechallenge/models/serializers.dart';
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

  // if response from server is Iterable then use this function:
  BuiltList<T> _handleListResponse<T>(Response response) {
    if (response.data == null) {
      return BuiltList<T>();
    }
    var rawList = (response.data as List<dynamic>);
    return BuiltList<T>(rawList.map((item) {
      if (T is String) {
        return item;
      } else {
        return serializers.deserializeWith<T>(
            serializers.serializerForType(T), item);
      }
    }).toList());
  }

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
              content: "<h5><center>Что-то пошло не так.</center></h5>",
              buttonText: 'Обновить',
              onPressed: _retry,
            ),
          );
        }

        if (snapshot.hasData) {
          final messageList = snapshot.data;

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
                          radius: 20,
                          photoUrl: messageList[index].img,
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: ClipRect(
                            child: Html(
                              data: "${messageList[index].text}",
                            ),
                          ),
                        ),
                        if (messageList[index].price != 0)
                          Text(
                            "-${messageList[index].price} ₽",
                            style: constants.defaultTextStyle
                                .copyWith(color: Color(0xFF00A072)),
                          ),
                      ],
                    ),
                  ),
                );
              },
              childCount: messageList.length,
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
