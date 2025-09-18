import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_website/utils/nav_item.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).state.matchedLocation;
    _currentIndex = NavItem.getMatchIndex(currentPath);

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: _getBotNavBarItemList(),
      onTap: (targetedIndex) {
        if (_currentIndex != targetedIndex) {
          final targetedNavItem = NavItem.values[targetedIndex];
          context.go(targetedNavItem.locationName);
        }
      },
    );
  }

  List<BottomNavigationBarItem> _getBotNavBarItemList() {
    return NavItem.values
        .map((e) => BottomNavigationBarItem(
            tooltip: e.label,
            label: e.label,
            icon: e.icon,
            activeIcon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(173, 90, 90, 92),
              ),
              child: Icon(
                e.selectedIcon.icon,
              ),
            )))
        .toList();
  }
}
