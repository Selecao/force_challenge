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
              constants.boxShadow,
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
