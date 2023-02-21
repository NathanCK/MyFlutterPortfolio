import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/bloc/app_status_bloc.dart';
import 'package:my_flutter_website/screens/app_screen.dart';
import 'package:my_flutter_website/utils/my_theme.dart';

void main() {
  final AppStatusBloc appStatusBloc = AppStatusBloc();

  runApp(MyApp(appStatusBloc: appStatusBloc));
}

class MyApp extends StatelessWidget {
  final AppStatusBloc appStatusBloc;
  final routerDelegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => AppScreen(),
      },
    ),
  );

  MyApp({super.key, required this.appStatusBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppStatusBloc>(create: (_) => appStatusBloc),
        ],
        child: MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: BeamerParser(),
          theme: ThemeData.light().copyWith(
              bottomNavigationBarTheme: myBottomNavigationBarThemeData,
              extensions: [
                myDrawerLightTheme,
              ]),
        ));
  }
}
