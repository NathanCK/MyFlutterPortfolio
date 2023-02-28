import 'package:flutter/widgets.dart';

class TextUtils {
  static Size calculateTextSize(String text,
      {TextDirection textDirection = TextDirection.ltr, TextStyle? style}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), textDirection: textDirection)
      ..layout();
    return textPainter.size;
  }
}
