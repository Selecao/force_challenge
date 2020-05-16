import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as dom;

/// parser for rich text with html tags

typedef SpanBuilder = TextSpan Function(String tag, String text);

List<TextSpan> parseSpans(
    {@required String source, @required SpanBuilder spanBuilder}) {
  var spans = <TextSpan>[];

  var parsed = html.parseFragment(source);
  for (var node in parsed.nodes) {
    var span;
    if (node is dom.Text) {
      span = spanBuilder(null, node.text);
    } else if (node is dom.Element) {
      span = spanBuilder(node.localName, node.text);
    }
    if (span == null) {
      throw 'spanBuilder returned null! Do you forget to type \'return\' keyword?';
    }
    spans.add(span);
  }
  return spans;
}
