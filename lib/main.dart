import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/bloc/app_status_bloc.dart';
import 'package:my_flutter_website/screens/app_screen.dart';
import 'package:my_flutter_website/utils/my_theme.dart';

import 'beam_locations/home_location.dart';

void main() {
  final AppStatusBloc appStatusBloc = AppStatusBloc();
  Beamer.setPathUrlStrategy();

  runApp(MyApp(appStatusBloc: appStatusBloc));
}

class MyApp extends StatelessWidget {
  final AppStatusBloc appStatusBloc;
  final routerDelegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        AppPath.home: (context, state, data) => AppScreen(),
        AppPath.about: (context, state, data) => AppScreen(),
        AppPath.experience: (context, state, data) => AppScreen(),
      },
    ),
    notFoundRedirectNamed: AppPath.home,
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
              navigationRailTheme: myNavigationRailThemeData,
              extensions: [
                myDrawerLightTheme,
              ]),
        ));
  }
}
