import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/bloc/analytics_bloc.dart';
import 'package:my_flutter_website/bloc/app_status_bloc.dart';
import 'package:my_flutter_website/firebase_options.dart';
import 'package:my_flutter_website/generated/l10n.dart';
import 'package:my_flutter_website/screens/app_background.dart';
import 'package:my_flutter_website/utils/my_theme.dart';

Future<void> main() async {
  await _init();

  final AppStatusBloc appStatusBloc = AppStatusBloc();
  final AnalyticsBloc analyticsBloc = AnalyticsBloc();

  usePathUrlStrategy(); // Github Pages doesn't support that for now

  FirebaseAnalytics? analyticsInstance;
  try {
    analyticsInstance = FirebaseAnalytics.instance;
  } catch (e) {
    debugPrint('failed to get analytics instance');
  }

  final List<NavigatorObserver> navigatorObservers = [];

  if (analyticsInstance != null) {
    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analyticsInstance);

    navigatorObservers.add(observer);
  }

  final router = MainRouter().initializeRouter();

  runApp(MyApp(
    appStatusBloc: appStatusBloc,
    router: router,
    analyticsBloc: analyticsBloc,
  ));
}

Future<void> _init() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('failed to initialize Firebase service: $e');
  }
}

class MyApp extends StatelessWidget {
  final AppStatusBloc appStatusBloc;
  final AnalyticsBloc analyticsBloc;
  final GoRouter _router;

  const MyApp({
    super.key,
    required GoRouter router,
    required this.appStatusBloc,
    required this.analyticsBloc,
  }) : _router = router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppStatusBloc>(create: (_) => appStatusBloc),
          BlocProvider<AnalyticsBloc>(create: (_) => analyticsBloc),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: _router,
          builder: (context, child) {
            final foregroundScreen = child ?? const SizedBox.shrink();

            return Stack(
              children: [
                Positioned.fill(
                  child: AppBackground(),
                ),
                foregroundScreen,
              ],
            );
          },
          theme: lightTheme.copyWith(
            bottomNavigationBarTheme: myBottomNavigationBarThemeData,
            navigationRailTheme: myNavigationRailThemeData,
            scaffoldBackgroundColor: Colors.transparent,
            extensions: [
              myDrawerLightTheme,
            ],
          ),
        ));
  }
}
