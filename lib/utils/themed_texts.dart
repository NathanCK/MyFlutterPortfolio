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
    final style = Theme.of(context).primaryTextTheme.displayLarge!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
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
    final style = Theme.of(context).primaryTextTheme.displayMedium!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
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
    final style = Theme.of(context).primaryTextTheme.displaySmall!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
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
    final style = Theme.of(context).primaryTextTheme.bodyLarge!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
    );
  }
}

class BodyMediumText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;
  final double stepGranularity;

  const BodyMediumText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      this.stepGranularity = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.bodyMedium!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
    );
  }
}

class BodySmallText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;
  final double stepGranularity;

  const BodySmallText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      this.stepGranularity = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.bodySmall!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
    );
  }
}

class TitleLargeText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const TitleLargeText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.titleLarge!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class TitleMediumText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const TitleMediumText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.titleMedium!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class TitleSmallText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const TitleSmallText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).primaryTextTheme.titleSmall!;
    return AutoSizeText(
      text,
      style: titleStyle.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class HeadlineLargeText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const HeadlineLargeText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.headlineLarge!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class HeadlineMediumText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const HeadlineMediumText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.headlineMedium!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class HeadlineSmallText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const HeadlineSmallText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.headlineSmall!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class LabelLargeText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const LabelLargeText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.labelLarge!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class LabelMediumText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const LabelMediumText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.labelMedium!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}

class LabelSmallText extends ThemedText {
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double maxFontSize;

  const LabelSmallText(super.text,
      {this.textAlign,
      this.maxLines,
      this.overflow,
      this.maxFontSize = double.infinity,
      super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.labelSmall!;
    return AutoSizeText(
      text,
      style: style.copyWith(overflow: overflow),
      textAlign: textAlign,
      maxLines: maxLines,
      maxFontSize: maxFontSize,
    );
  }
}
