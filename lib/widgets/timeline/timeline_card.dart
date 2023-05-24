import 'package:flutter/material.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/utils/date_time_utils.dart';
import 'package:my_flutter_website/utils/themed_texts.dart';

class TimelineCard extends StatelessWidget {
  final TimelineEventModel data;
  final ScreenSizeType? screenSizeType;

  const TimelineCard({
    super.key,
    required this.data,
    this.screenSizeType,
  });

  @override
  Widget build(BuildContext context) {
    Widget title;
    Widget date;
    Widget? subTitle;
    Widget? shortDescription;

    switch (screenSizeType) {
      case ScreenSizeType.big:
        title = HeadlineLargeText(data.title);
        date = LabelLargeText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.subtitle != null) subTitle = TitleLargeText(data.subtitle!);
        if (data.shortDescription != null) {
          shortDescription = BodyLargeText(data.subtitle!);
        }
        break;
      case ScreenSizeType.medium:
        title = HeadlineMediumText(data.title);
        if (data.subtitle != null) subTitle = TitleMediumText(data.subtitle!);
        date = LabelMediumText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.shortDescription != null) {
          shortDescription = BodyMediumText(data.subtitle!);
        }
        break;
      case null:
      case ScreenSizeType.small:
      default:
        title = HeadlineSmallText(data.title);
        date = LabelSmallText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.subtitle != null) subTitle = TitleSmallText(data.subtitle!);
        if (data.shortDescription != null) {
          shortDescription = BodySmallText(data.subtitle!);
        }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.icon != null)
          Center(
            child: SizedBox(
              height: 100,
              child: data.icon!,
            ),
          ),
        title,
        if (subTitle != null) subTitle,
        date,
        if (shortDescription != null) shortDescription,
      ],
    );
  }
}
