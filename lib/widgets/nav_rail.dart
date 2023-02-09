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

  @override
  void initState() {
    super.initState();

    widget.beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    final currentPath =
        (context.currentBeamLocation.state as BeamState).uri.path;
    _currentIndex = NavItem.getMatchIndex(currentPath);

    return NavigationRail(
        destinations: _getNavItemList(),
        onDestinationSelected: (targetedIndex) => widget.beamerDelegate
            .beamToNamed(NavItem.values[targetedIndex].url),
        selectedIndex: _currentIndex);
  }

  List<NavigationRailDestination> _getNavItemList() {
    return NavItem.values
        .map((e) => NavigationRailDestination(
            icon: e.icon, selectedIcon: e.selectedIcon, label: Text(e.label)))
        .toList();
  }

  @override
  void dispose() {
    widget.beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}
