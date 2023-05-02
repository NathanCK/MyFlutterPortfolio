part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object> get props => [];
}

class AnalyticsInitialized extends AnalyticsEvent {}

class AnalyticsOutLinkButtonPressed extends AnalyticsEvent {
  final String sourceName;

  const AnalyticsOutLinkButtonPressed(this.sourceName);

  @override
  List<Object> get props => [sourceName];
}
