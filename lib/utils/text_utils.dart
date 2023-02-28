import 'package:flutter/widgets.dart';

class TextUtils {
  static Size calculateTextSize(String text, {TextStyle? style}) {
    final TextPainter textPainter =
        TextPainter(text: TextSpan(text: text, style: style))..layout();
    return textPainter.size;
  }
}
