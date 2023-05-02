import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  FirebaseAnalytics? _analyticsInstance;

  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<AnalyticsEvent>(_onAnalyticsInitialized);
    on<AnalyticsOutLinkButtonPressed>(_onAnalyticsOutLinkButtonPressed);

    add(AnalyticsInitialized());
  }

  void _onAnalyticsInitialized(
      AnalyticsEvent event, Emitter<AnalyticsState> emit) {
    if (_analyticsInstance != null) return;

    try {
      _analyticsInstance = FirebaseAnalytics.instance;
    } catch (e) {
      debugPrint('failed to get analytics instance');
    }
  }

  Future<void> _onAnalyticsOutLinkButtonPressed(
      AnalyticsOutLinkButtonPressed event, Emitter<AnalyticsState> emit) async {
    if (_analyticsInstance == null) return;

    try {
      if (await _analyticsInstance!.isSupported()) {
        await _analyticsInstance!.logEvent(
          name: 'out_link_pressed',
          parameters: {'source_name': event.sourceName},
        );
      }
    } catch (e) {
      debugPrint('Failed to log the event: $e');
    }
  }
}
