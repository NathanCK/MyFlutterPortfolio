import 'package:flutter/material.dart';
import 'package:my_flutter_website/routes/constants.dart';

enum NavItem {
  home('home.dart', AppRouteNames.home, Icon(Icons.home),
      Icon(Icons.home_outlined)),
  experience('experience.dart', AppRouteNames.experience, Icon(Icons.book),
      Icon(Icons.book_outlined));

  const NavItem(this.label, this.locationName, this.icon, this.selectedIcon);
  final String locationName;
  final String label;
  final Icon icon;
  final Icon selectedIcon;

  /// will return 0 if not found by the [url]
  static int getMatchIndex(String url) {
    final searchResult = NavItem.values
        .indexWhere((element) => url.contains(element.locationName));
    return searchResult == -1 ? 0 : searchResult;
  }
}
