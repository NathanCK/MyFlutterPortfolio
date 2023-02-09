import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key, required this.beamerKey});

  final GlobalKey<BeamerState> beamerKey;

  @override
  State<StatefulWidget> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  late BeamerDelegate _beamerDelegate;
  int _currentIndex = 0;

  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    _beamerDelegate = widget.beamerKey.currentState!.routerDelegate;
    _beamerDelegate.addListener(_setStateListener);
  }

  @override
  Widget build(BuildContext context) {
    final currentPath =
        (context.currentBeamLocation.state as BeamState).uri.path;
    _currentIndex = NavItem.getMatchIndex(currentPath);

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: _getBotNavBarItemList(),
      onTap: (index) => _beamerDelegate.beamToNamed(
        NavItem.values[index].url,
      ),
    );
  }

  List<BottomNavigationBarItem> _getBotNavBarItemList() {
    return NavItem.values
        .map((e) => BottomNavigationBarItem(
            label: e.label, icon: e.icon, activeIcon: e.selectedIcon))
        .toList();
  }

  @override
  void dispose() {
    _beamerDelegate.removeListener(_setStateListener);
    super.dispose();
  }
}
