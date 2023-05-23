import 'package:flutter/widgets.dart';

class TimelineEventModel implements Comparable<TimelineEventModel> {
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  final String? subtitle;
  final String? shortDescription;
  final String? longDescription;
  final Widget? timelineDotWidget;
  final Widget? icon;

  TimelineEventModel(
    this.startDate,
    this.endDate,
    this.title, {
    this.subtitle,
    this.shortDescription,
    this.longDescription,
    this.timelineDotWidget,
    this.icon,
  });

  @override
  int compareTo(TimelineEventModel other) {
    return startDate.compareTo(other.startDate);
  }
}
