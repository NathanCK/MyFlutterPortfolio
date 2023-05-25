import 'package:beamer/beamer.dart';
import 'package:conway_game_of_life/game_board.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/beam_locations/experience_location.dart';
import 'package:my_flutter_website/beam_locations/home_location.dart';
import 'package:my_flutter_website/enum/nav_bar_type.dart';
import 'package:my_flutter_website/widgets/app_dock.dart';

class AppScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final BeamerDelegate _routerDelegate;

  final List<NavigatorObserver> navigatorObservers;

  AppScreen({super.key, this.navigatorObservers = const <NavigatorObserver>[]})
      : _routerDelegate = BeamerDelegate(
          navigatorObservers: [HeroController(), ...navigatorObservers],
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
                Opacity(
                  opacity: 0.3,
                  child: GameBoard(
                    height: boxConstraints.maxHeight,
                    width: boxConstraints.maxWidth,
                    cellSize: 7,
                    duration: const Duration(milliseconds: 500),
                    shouldAutoStart: true,
                    showControlPanel: false,
                  ),
                ),
                Beamer(
                  key: _beamerKey,
                  routerDelegate: _routerDelegate,
                ),
              ]),
            ),
          ],
        ),
        bottomNavigationBar: null,
        floatingActionButton: AppDock(
          beamerKey: _beamerKey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
