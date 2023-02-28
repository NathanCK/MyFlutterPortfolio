import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_home_page_event.dart';
part 'my_home_page_state.dart';

class MyHomePageBloc extends Bloc<MyHomePageEvent, MyHomePageState> {
  MyHomePageBloc() : super(MyHomePageInitial()) {
    on<HomePageWelcomeGreetingEnded>(_onHomePageWelcomeGreetingEnded);
  }

  FutureOr<void> _onHomePageWelcomeGreetingEnded(
      HomePageWelcomeGreetingEnded event, Emitter<MyHomePageState> emit) {
    emit(HomePageWelcomeGreetingSuccess());
  }
}
