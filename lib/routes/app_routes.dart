import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/routes/experience_routes.dart';
import 'package:my_flutter_website/routes/home_routes.dart';
import 'package:my_flutter_website/screens/welcome_screen.dart';
import 'package:my_flutter_website/widgets/app_dock.dart';

abstract class AppRouter {
  RouteBase buildRoutes();
}

class MainRouter {
  GoRouter initializeRouter() {
    final homeRoutes = HomeRouter().buildRoutes();
    final experienceRoutes = ExperienceRouter().buildRoutes();

    final shellRoutes = ShellRoute(
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
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return WelcomeScreen();
          },
          routes: [shellRoutes],
        ),
      ],
    );
  }
}
