import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/routes/app_routes.dart';
import 'package:my_flutter_website/routes/constants.dart';
import 'package:my_flutter_website/screens/experience_details_page.dart';
import 'package:my_flutter_website/screens/experience_list_page.dart';

class ExperienceRouter extends AppRouter {
  @override
  RouteBase buildRoutes() {
    return GoRoute(
      name: AppRouteNames.experience,
      path: 'experience',
      builder: (context, state) => ExperienceListPage(),
      routes: [
        GoRoute(
          name: AppRouteNames.experienceDetails,
          path: ':id',
          pageBuilder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);

            return CustomTransitionPage(
                barrierDismissible: true,
                opaque: false,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: ExperienceDetailsPage(id: id));
          },
          redirect: (context, state) {
            final id = int.tryParse(state.pathParameters['id']!);
            if (id == null) {
              return AppRouteNames.experience;
            }

            return null;
          },
        ),
      ],
    );
  }
}
