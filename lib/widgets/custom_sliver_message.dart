import 'package:flutter/material.dart';

import 'package:forcechallenge/constants.dart' as constants;

class CustomSliverMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: constants.backgroundLight,
            borderRadius: constants.framesRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2.0, // has the effect of softening the shadow
                spreadRadius: 0.0, // has the effect of extending the shadow
                offset: Offset(
                  2.0, // horizontal, move right 10
                  4.0, // vertical, move down 10
                ),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: constants.defaultDarkTextStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Вы впервые?\n',
                      style: constants.boldDarkTextStyle),
                  TextSpan(
                      text:
                          'Это очень важное сообщение. Пожалуйста, нажмите на кнопку ниже.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
