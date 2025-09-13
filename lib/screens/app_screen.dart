import 'package:beamer/beamer.dart';
import 'package:conway_game_of_life/game_of_life_board.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';
import 'package:my_flutter_website/beam_locations/experience_location.dart';
import 'package:my_flutter_website/beam_locations/home_location.dart';
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
          ).call,
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
                  child: GameOfLife(
                    cellSize: 7,
                    autoStart: true,
                    showControlPanel: false,
                    speed: Duration(milliseconds: 500),
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
}
