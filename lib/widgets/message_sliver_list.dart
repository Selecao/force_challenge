import 'package:flutter/material.dart';

import 'package:built_collection/built_collection.dart';

import 'package:forcechallenge/components/application/app_theme.dart';
import 'package:forcechallenge/components/span_parser.dart';
import 'package:forcechallenge/widgets/avatar.dart';
import '../models/notification.dart' as a;

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
                        child: Text.rich(
                          TextSpan(
                            children: parseSpans(
                              source: notificationList[index].text,
                              spanBuilder: (tag, text) {
                                switch (tag) {
                                  case 'b':
                                    return TextSpan(
                                      text: text,
                                      style: AppTheme.of(context)
                                          .bodyDarkTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    );
                                  case 'y':
                                    return TextSpan(
                                      text: text,
                                      style: AppTheme.of(context)
                                          .bodyDarkTextStyle
                                          .copyWith(
                                              fontStyle: FontStyle.italic),
                                    );
                                  case 'u':
                                    return TextSpan(
                                      text: text,
                                      style: AppTheme.of(context)
                                          .bodyDarkTextStyle
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                    );
                                  default:
                                    return TextSpan(
                                      text: text,
                                      style: AppTheme.of(context)
                                          .bodyDarkTextStyle,
                                    );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      if (notificationList[index].price != 0)
                        Row(
                          children: <Widget>[
                            SizedBox(width: 20),
                            Text(
                              "-${notificationList[index].price} ₽",
                              style: AppTheme.of(context)
                                  .bodyDarkTextStyle
                                  .copyWith(
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
                    color: AppTheme.of(context).graySeparatorColor,
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
