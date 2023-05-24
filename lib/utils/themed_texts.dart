import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/text_utils.dart';

abstract class ThemedText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const ThemedText(this.text, {super.key, this.style});

  Size get size {
    return TextUtils.calculateTextSize(text, style: style);
  }
}

class DisplayLargeText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const DisplayLargeText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.displayLarge!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class DisplayMediumText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const DisplayMediumText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.displayMedium!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class DisplaySmallText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const DisplaySmallText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.displaySmall!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class BodyLargeText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;
  final double stepGranularity;

  const BodyLargeText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      this.stepGranularity = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.bodyLarge!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
    );
  }
}
