import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/routes/app_routes.dart';
import 'package:my_flutter_website/routes/constants.dart';
import 'package:my_flutter_website/screens/home_page.dart';

class HomeRouter extends AppRouter {
  @override
  RouteBase buildRoutes() {
    return GoRoute(
      name: AppRouteNames.home,
      path: 'home',
      builder: (context, state) => MyHomePage(),
    );
  }
}
