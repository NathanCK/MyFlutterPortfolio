import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/beam_locations/experience_location.dart';
import 'package:my_flutter_website/beam_locations/home_location.dart';
import 'package:my_flutter_website/enum/nav_bar_type.dart';

class AppScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final BeamerDelegate _routerDelegate;

  final List<NavigatorObserver> navigatorObservers;

  AppScreen({super.key, this.navigatorObservers = const <NavigatorObserver>[]})
      : _routerDelegate = BeamerDelegate(
          navigatorObservers: navigatorObservers,
          transitionDelegate: const NoAnimationTransitionDelegate(),
          locationBuilder: BeamerLocationBuilder(
            beamLocations: [
              HomeLocation(),
              ExperienceLocation(),
            ],
          ),
          notFoundRedirectNamed: AppPath.home,
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: null,
        body: Row(
          children: [
            Expanded(
              child: Stack(children: [
                Beamer(
                  key: _beamerKey,
                  routerDelegate: _routerDelegate,
                ),
              ]),
            ),
          ],
        ),
        bottomNavigationBar: null,
      );
    });
  }

  NavBarType _getNavBarType(double screenHeight, double screenWidth) {
    if (screenHeight <= 400 || screenWidth <= 375) {
      return NavBarType.drawer;
    }

    if (screenWidth >= 820) {
      return NavBarType.navRail;
    }

    return NavBarType.botNavBar;
  }
}
