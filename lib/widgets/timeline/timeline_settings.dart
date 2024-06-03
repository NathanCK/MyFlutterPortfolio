import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TimelineSettings extends Equatable {
  final double eventItemWidth;
  final double connectorHeightOnEven;
  final double connectorHeightOnOdd;
  final Widget? defaultEventMakerWidget;
  final double eventMakerSize;
  final bool shouldDisplayEventTime;
  final double bottomAreaHeight;
  final TextStyle? monthTextStyle;
  final TextStyle? yearTextStyle;
  final Color lineColor;
  final double lineWidth;

  const TimelineSettings({
    this.eventItemWidth = 300,
    this.connectorHeightOnEven = 120,
    this.connectorHeightOnOdd = 170,
    this.eventMakerSize = 16,
    this.bottomAreaHeight = 70,
    this.lineColor = Colors.black,
    this.lineWidth = 4,
    this.shouldDisplayEventTime = true,
    this.defaultEventMakerWidget,
    this.monthTextStyle,
    this.yearTextStyle,
  });

  TimelineSettings copyWith({
    double? eventItemWidth,
    double? connectorHeightOnEven,
    double? connectorHeightOnOdd,
    Widget? defaultEventMakerWidget,
    double? eventMakerSize,
    bool? shouldDisplayEventTime,
    double? bottomAreaHeight,
    TextStyle? monthTextStyle,
    TextStyle? yearTextStyle,
  }) {
    return TimelineSettings(
      eventItemWidth: eventItemWidth ?? this.eventItemWidth,
      connectorHeightOnEven:
          connectorHeightOnEven ?? this.connectorHeightOnEven,
      connectorHeightOnOdd: connectorHeightOnOdd ?? this.connectorHeightOnOdd,
      defaultEventMakerWidget:
          defaultEventMakerWidget ?? this.defaultEventMakerWidget,
      eventMakerSize: eventMakerSize ?? this.eventMakerSize,
      shouldDisplayEventTime:
          shouldDisplayEventTime ?? this.shouldDisplayEventTime,
      bottomAreaHeight: bottomAreaHeight ?? this.bottomAreaHeight,
      monthTextStyle: monthTextStyle ?? this.monthTextStyle,
      yearTextStyle: yearTextStyle ?? this.yearTextStyle,
    );
  }

  @override
  List<Object?> get props => [
        eventItemWidth,
        connectorHeightOnEven,
        connectorHeightOnOdd,
        eventMakerSize,
        shouldDisplayEventTime,
        bottomAreaHeight,
        defaultEventMakerWidget,
        monthTextStyle,
        yearTextStyle,
      ];
}
