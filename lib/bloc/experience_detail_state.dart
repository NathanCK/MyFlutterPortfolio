part of 'experience_detail_bloc.dart';

@immutable
abstract class ExperienceDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExperienceDetailInitial extends ExperienceDetailState {}

class ExperienceDetailLoadSuccess extends ExperienceDetailState {
  final TimelineEventModel data;

  ExperienceDetailLoadSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ExperienceDetailLoadFailed extends ExperienceDetailState {}
