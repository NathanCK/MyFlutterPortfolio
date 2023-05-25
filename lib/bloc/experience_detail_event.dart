part of 'experience_detail_bloc.dart';

@immutable
abstract class ExperienceDetailEvent extends Equatable {
  const ExperienceDetailEvent();

  @override
  List<Object> get props => [];
}

class ExperienceDetailInitialized extends ExperienceDetailEvent {}
