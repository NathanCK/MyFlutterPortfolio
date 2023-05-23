import 'package:flutter/material.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/utils/date_time_utils.dart';

class TimelineCard extends StatelessWidget {
  final TimelineEventModel data;

  const TimelineCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (data.icon != null)
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: FittedBox(
                fit: BoxFit.fill,
                child: data.icon!,
              ),
            ),
          ),
        Text(data.title),
        if (data.subtitle != null) Text(data.subtitle!),
        Text('${data.startDate.toStringMY()} - ${data.endDate.toStringMY()}'),
        if (data.shortDescription != null)
          Text(
            data.shortDescription!,
          ),
      ],
    );
  }
}
