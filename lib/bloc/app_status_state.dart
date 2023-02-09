part of 'app_status_bloc.dart';

@immutable
abstract class AppStatusState extends Equatable {}

class AppStatusInitial extends AppStatusState {
  @override
  List<Object?> get props => [];
}

class NavBarTypeChanged extends AppStatusState {
  final NavBarType newNavBarType;

  NavBarTypeChanged(this.newNavBarType);

  @override
  List<Object?> get props => [newNavBarType];
}
