part of 'app_status_bloc.dart';

@immutable
abstract class AppStatusEvent extends Equatable {}

class NavBarTypeChangeRequested extends AppStatusEvent {
  final NavBarType newType;

  NavBarTypeChangeRequested(this.newType);

  @override
  List<Object?> get props => [newType];
}
