import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/routes/experience_routes.dart';
import 'package:my_flutter_website/routes/home_routes.dart';
import 'package:my_flutter_website/screens/welcome_page.dart';
import 'package:my_flutter_website/widgets/app_dock.dart';

abstract class AppRouter {
  RouteBase buildRoutes();
}

class MainRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  GoRouter initializeRouter() {
    final homeRoutes = HomeRouter().buildRoutes();
    final experienceRoutes = ExperienceRouter().buildRoutes();

    final shellRoutes = ShellRoute(
      navigatorKey: _shellNavigatorKey,
      routes: [
        homeRoutes,
        experienceRoutes,
      ],
      builder: (context, state, child) {
        return Scaffold(
          floatingActionButton: AppDock(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: child,
        );
      },
    );

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return WelcomePage();
          },
          routes: [shellRoutes],
        ),
      ],
    );
  }
}
