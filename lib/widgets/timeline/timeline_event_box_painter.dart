import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/date_time_utils.dart';

class TimelineEventBoxPainter extends CustomPainter {
  final DateTime date;
  final double timelineGap;
  final double makerIconSize;
  final bool isFirst;
  final bool isLast;
  final TextStyle monthTextStyle;
  final TextStyle yearTextStyle;
  final double timelineBarHeight;
  final bool displayEventTime;
  final Color strokeColor;
  final double strokeWidth;

  TimelineEventBoxPainter({
    required this.date,
    required this.timelineGap,
    required this.makerIconSize,
    required this.isFirst,
    required this.isLast,
    required this.monthTextStyle,
    required this.yearTextStyle,
    required this.timelineBarHeight,
    required this.displayEventTime,
    required this.strokeColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerW = size.width / 2;
    final makerCenterSize = makerIconSize / 2;
    final bottom = size.height;

    final paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth;

    final horizontalLinePosition = bottom - timelineBarHeight;

    if (isFirst) {
      var rect = Rect.fromPoints(Offset(0, horizontalLinePosition),
          Offset((centerW - (makerCenterSize)) / 3, horizontalLinePosition));

      paint.shader = LinearGradient(colors: [
        strokeColor.withOpacity(0),
        strokeColor,
      ]).createShader(rect);
    }

    canvas.drawLine(Offset(0, horizontalLinePosition),
        Offset(centerW - (makerCenterSize), horizontalLinePosition), paint);

    paint.shader = null;

    if (isLast) {
      var rect = Rect.fromPoints(
          Offset((size.width - ((centerW + makerCenterSize) / 3)),
              horizontalLinePosition),
          Offset(size.width, horizontalLinePosition));

      paint.shader = LinearGradient(colors: [
        strokeColor,
        strokeColor.withOpacity(0),
      ]).createShader(rect);
    }

    canvas.drawLine(Offset(centerW + (makerCenterSize), horizontalLinePosition),
        Offset(size.width, horizontalLinePosition), paint);

    paint.shader = null;

    canvas.drawLine(Offset(centerW, horizontalLinePosition - (makerCenterSize)),
        Offset(centerW, bottom - timelineGap), paint);

    if (displayEventTime) {
      final monthTextSpan = TextSpan(
          text: TimelineDateExtension.monthStringConvertMap[date.month]!,
          style: monthTextStyle);
      TextPainter monthTextPainter =
          TextPainter(text: monthTextSpan, textDirection: TextDirection.rtl);
      monthTextPainter.layout();

      final monthTextOffset = Offset(centerW - (monthTextPainter.width / 2),
          bottom - (timelineBarHeight - 15) - (monthTextPainter.height / 2));

      monthTextPainter.paint(canvas, monthTextOffset);

      final yearTextSpan =
          TextSpan(text: date.year.toString(), style: yearTextStyle);
      TextPainter yearTextPainter =
          TextPainter(text: yearTextSpan, textDirection: TextDirection.rtl);

      yearTextPainter.layout();

      final yearTextOffset = Offset(
          centerW - (yearTextPainter.width / 2),
          bottom -
              (timelineBarHeight - 20) +
              monthTextPainter.height -
              (yearTextPainter.height / 2));

      yearTextPainter.paint(canvas, yearTextOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
