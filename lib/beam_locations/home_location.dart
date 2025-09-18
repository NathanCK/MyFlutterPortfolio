import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/beam_locations/constants.dart';
import 'package:my_flutter_website/screens/home_screen.dart';

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
