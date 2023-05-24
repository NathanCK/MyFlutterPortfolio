import 'package:flutter/material.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/utils/date_time_utils.dart';

class SelectedTimelineCard extends StatelessWidget {
  final TimelineEventModel data;
  final double width;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SelectedTimelineCard({
    super.key,
    required this.data,
    required this.width,
    this.decoration,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: data.title,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: width,
          padding: padding,
          margin: margin,
          decoration: decoration,
          child: Column(
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
              Text(
                data.title,
              ),
              if (data.subtitle != null)
                Text(
                  data.subtitle!,
                ),
              Text(
                '${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}',
              ),
              if (data.longDescription != null)
                Text(
                  data.longDescription!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
