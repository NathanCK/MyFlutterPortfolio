part of 'my_home_page_bloc.dart';

abstract class MyHomePageEvent extends Equatable {
  const MyHomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageWelcomeGreetingEnded extends MyHomePageEvent {}

class HomePageWelcomeGreetingMoved extends MyHomePageEvent {}
