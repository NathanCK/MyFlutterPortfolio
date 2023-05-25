import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';
import 'package:my_flutter_website/utils/my_experience_data.dart';

part 'experience_detail_event.dart';
part 'experience_detail_state.dart';

class ExperienceDetailBloc
    extends Bloc<ExperienceDetailEvent, ExperienceDetailState> {
  final int id;

  ExperienceDetailBloc({required this.id}) : super(ExperienceDetailInitial()) {
    on<ExperienceDetailInitialized>(_onExperienceDetailInitialized);

    add(ExperienceDetailInitialized());
  }

  FutureOr<void> _onExperienceDetailInitialized(
      ExperienceDetailInitialized event, Emitter<ExperienceDetailState> emit) {
    try {
      final TimelineEventModel data =
          timelineEventModels.firstWhere((e) => e.id == id);

      emit(ExperienceDetailLoadSuccess(data));
    } catch (e) {
      debugPrint('$e');

      emit(ExperienceDetailLoadFailed());
    }
  }
}
