import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';

enum NavItem {
  home('Home.dart', AppPath.home, Icon(Icons.home), Icon(Icons.home_outlined));

  const NavItem(this.label, this.url, this.icon, this.selectedIcon);
  final String url;
  final String label;
  final Icon icon;
  final Icon selectedIcon;

  /// will return 0 if not found by the [url]
  static int getMatchIndex(String url) {
    final searchResult =
        NavItem.values.indexWhere((element) => url.contains(element.url));
    return searchResult == -1 ? 0 : searchResult;
  }
}
