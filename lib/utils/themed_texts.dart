import 'package:flutter/widgets.dart';
import 'package:my_flutter_website/utils/text_utils.dart';

abstract class ThemedText {
  final String text;
  final TextStyle? style;

  ThemedText(this.text, {this.style});

  Size get size {
    return TextUtils.calculateTextSize(text, style: style);
  }
}
