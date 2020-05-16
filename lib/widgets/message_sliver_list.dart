import 'package:flutter/material.dart';

import 'package:built_collection/built_collection.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:forcechallenge/widgets/avatar.dart';
import '../models/notification.dart' as a;
import 'package:forcechallenge/constants.dart' as constants;

class MessageSliverList extends StatelessWidget {
  MessageSliverList({this.backgroundColor, this.notificationList});
  final BuiltList<a.Notification> notificationList;
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
                    borderRadius: getBorder(index, notificationList),
                    color: backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Avatar(
                        radius: 20,
                        photoUrl: notificationList[index].img,
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Html(
                          data: "${notificationList[index].text}",
                          useRichText: true,
                          //shrinkToFit: false,
                        ),
                      ),
                      if (notificationList[index].price != 0)
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              "-${notificationList[index].price} ₽",
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
                if (index != (notificationList.length - 1))
                  Divider(
                    height: 0.0,
                    thickness: 1.0,
                    color: constants.greySeparator,
                  ),
              ],
            ),
          );
        },
        childCount: notificationList.length,
      ),
    );
  }

  BorderRadius getBorder(int index, BuiltList<dynamic> list) {
    if (index == 0) {
      return BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      );
    } else if (index == list.length - 1) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      );
    } else
      return null;
  }
}
