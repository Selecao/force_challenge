import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

import 'package:forcechallenge/constants.dart' as constants;

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
