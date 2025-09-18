import 'package:flutter/material.dart';
import 'package:my_flutter_website/enum/screen_size_type.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/utils/date_time_utils.dart';
import 'package:my_flutter_website/utils/themed_texts.dart';

class SelectedTimelineCard extends StatelessWidget {
  static const SizedBox _defaultSpace = SizedBox(height: 16);

  final TimelineEventModel data;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final ScreenSizeType? screenSizeType;

  const SelectedTimelineCard({
    super.key,
    required this.data,
    this.decoration,
    this.padding,
    this.margin,
    this.screenSizeType,
  });

  @override
  Widget build(BuildContext context) {
    Widget title;
    Widget date;
    Widget? subTitle;
    Widget? longDescription;

    switch (screenSizeType) {
      case ScreenSizeType.big:
        title = HeadlineLargeText(data.title);
        date = LabelLargeText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.subtitle != null) subTitle = TitleLargeText(data.subtitle!);
        if (data.longDescription != null) {
          longDescription = BodyLargeText(
            data.longDescription!,
            textAlign: TextAlign.justify,
          );
        }
        break;
      case ScreenSizeType.medium:
        title = HeadlineMediumText(data.title);
        if (data.subtitle != null) subTitle = TitleMediumText(data.subtitle!);
        date = LabelMediumText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.longDescription != null) {
          longDescription = BodyMediumText(data.longDescription!);
        }
        break;
      case null:
      case ScreenSizeType.small:
        title = HeadlineSmallText(data.title);
        date = LabelSmallText(
            '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}');
        if (data.subtitle != null) subTitle = TitleSmallText(data.subtitle!);
        if (data.longDescription != null) {
          longDescription = BodySmallText(
            data.longDescription!,
          );
        }
    }

    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.icon != null)
                      Center(
                        child: SizedBox(
                          height: 200,
                          child: data.icon!,
                        ),
                      ),
                    _defaultSpace,
                    title,
                    if (subTitle != null) subTitle,
                    date,
                    if (longDescription != null) ...[
                      _defaultSpace,
                      longDescription,
                    ],
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
