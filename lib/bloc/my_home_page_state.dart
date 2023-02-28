part of 'my_home_page_bloc.dart';

abstract class MyHomePageState extends Equatable {
  const MyHomePageState();

  @override
  List<Object> get props => [];
}

class MyHomePageInitial extends MyHomePageState {}

class HomePageWelcomeGreetingSuccess extends MyHomePageState {}

class HomePageWelcomeGreetingMoveSuccess extends MyHomePageState {}
