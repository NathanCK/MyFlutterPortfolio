import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

class NavRail extends StatefulWidget {
  final BeamerDelegate beamerDelegate;

  const NavRail({super.key, required this.beamerDelegate});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  void _setStateListener() => setState(() {});

  int _currentIndex = 0;
  bool extendedRail = false;
  NavigationRailLabelType railLabelType = NavigationRailLabelType.selected;

  @override
  void initState() {
    super.initState();

    widget.beamerDelegate.addListener(_setStateListener);
  }

  _collapseRail() {
    setState(() {
      extendedRail = false;
      railLabelType = NavigationRailLabelType.selected;
    });
  }

  _toggleRail() {
    setState(() {
      extendedRail = !extendedRail;
      railLabelType = extendedRail
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPath =
        (context.currentBeamLocation.state as BeamState).uri.path;
    _currentIndex = NavItem.getMatchIndex(currentPath);

    final NavigationRailThemeData navigationRailTheme =
        NavigationRailTheme.of(context);

    final minRailWidth = navigationRailTheme.minWidth ?? 72;
    final minExtendedRailWidth = navigationRailTheme.minExtendedWidth ?? 256;

    final double leadingWidgetMinWidth =
        extendedRail ? minExtendedRailWidth : minRailWidth;

    return NavigationRail(
        leading: _NavRailExpansionButton(
          onPressed: _toggleRail,
          minWidth: leadingWidgetMinWidth,
        ),
        extended: extendedRail,
        labelType: railLabelType,
        destinations: _getNavItemList(),
        onDestinationSelected: (targetedIndex) {
          if (_currentIndex != targetedIndex) {
            widget.beamerDelegate
                .beamToNamed(NavItem.values[targetedIndex].url);
            _collapseRail();
          }
        },
        selectedIndex: _currentIndex);
  }

  List<NavigationRailDestination> _getNavItemList() {
    return NavItem.values
        .map(
          (e) => NavigationRailDestination(
              icon: e.icon,
              selectedIcon: e.selectedIcon,
              label: Text(
                e.label,
              ),
              padding: EdgeInsets.zero),
        )
        .toList();
  }

  @override
  void dispose() {
    widget.beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}

class _NavRailExpansionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double minWidth;

  const _NavRailExpansionButton(
      {required this.onPressed, required this.minWidth});

  @override
  Widget build(BuildContext context) {
    final Animation<double> navigationRailAnimation =
        NavigationRail.extendedAnimation(context);

    return AnimatedBuilder(
        animation: navigationRailAnimation,
        builder: (BuildContext context, Widget? child) {
          navigationRailAnimation.value;
          return ConstrainedBox(
            constraints: BoxConstraints(minWidth: minWidth),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  hoverColor: const Color.fromARGB(173, 90, 90, 92),
                  icon: Transform.rotate(
                    angle: -90 * pi / 180 * navigationRailAnimation.value,
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onPressed,
                ),
              ),
            ),
          );
        });
  }
}
