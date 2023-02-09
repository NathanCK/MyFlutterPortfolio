import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:my_flutter_website/enum/nav_bar_type.dart';

part 'app_status_event.dart';
part 'app_status_state.dart';

class AppStatusBloc extends Bloc<AppStatusEvent, AppStatusState> {
  NavBarType _navBarType = NavBarType.drawer;

  NavBarType get navBarType => _navBarType;

  AppStatusBloc() : super(AppStatusInitial()) {
    on<NavBarTypeChangeRequested>(_onNavBarTypeChangeRequested);
  }

  void _onNavBarTypeChangeRequested(
      NavBarTypeChangeRequested event, Emitter<AppStatusState> emit) {
    if (event.newType == _navBarType) return;

    _navBarType = event.newType;

    emit(NavBarTypeChanged(_navBarType));
  }
}
