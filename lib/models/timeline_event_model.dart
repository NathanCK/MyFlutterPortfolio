import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TimelineEventModel extends Equatable
    implements Comparable<TimelineEventModel> {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  final String? subtitle;
  final String? shortDescription;
  final String? longDescription;
  final Widget? timelineDotWidget;
  final Widget? icon;

  const TimelineEventModel(
    this.id,
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

  @override
  List<Object?> get props => [
        id,
        startDate,
        endDate,
        title,
        subtitle,
        shortDescription,
        longDescription,
        timelineDotWidget,
        icon,
      ];
}
