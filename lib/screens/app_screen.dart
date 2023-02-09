import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_website/beam_locations/experience_location.dart';
import 'package:my_flutter_website/beam_locations/home_location.dart';
import 'package:my_flutter_website/bloc/app_status_bloc.dart';
import 'package:my_flutter_website/enum/nav_bar_type.dart';
import 'package:my_flutter_website/widgets/app_drawer.dart';
import 'package:my_flutter_website/widgets/bot_nav_bar.dart';
import 'package:my_flutter_website/widgets/nav_rail.dart';

class AppScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _routerDelegate = BeamerDelegate(
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        ExperienceLocation(),
      ],
    ),
  );

  AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      final navBarType =
          _getNavBarType(boxConstraints.maxHeight, boxConstraints.maxWidth);

      if (context.read<AppStatusBloc>().navBarType != navBarType) {
        context
            .read<AppStatusBloc>()
            .add(NavBarTypeChangeRequested(navBarType));
      }

      return Scaffold(
        key: _scaffoldKey,
        drawer: (navBarType == NavBarType.drawer)
            ? AppDrawer(beamerKey: _beamerKey)
            : null,
        body: Row(
          children: [
            if (navBarType == NavBarType.navRail) ...[
              NavRail(
                beamerDelegate: _routerDelegate,
              ),
              const VerticalDivider(
                thickness: 1,
                width: 1,
              )
            ],
            Expanded(
              child: Stack(children: [
                Beamer(
                  key: _beamerKey,
                  routerDelegate: _routerDelegate,
                ),
                if (navBarType == NavBarType.drawer) ...[
                  IconButton(
                    padding: const EdgeInsets.all(12),
                    iconSize: 32,
                    color: Colors.black,
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                      size: 32,
                    ),
                  )
                ],
              ]),
            ),
          ],
        ),
        bottomNavigationBar: (navBarType == NavBarType.botNavBar)
            ? BotNavBar(beamerKey: _beamerKey)
            : null,
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
