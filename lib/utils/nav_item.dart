import 'package:flutter/material.dart';
import 'package:my_flutter_website/beam_locations/app_path.dart';

enum NavItem {
  home('Home.dart', AppPath.home, Icon(Icons.home), Icon(Icons.home_outlined)),
  experience('Experience.dart', AppPath.experience, Icon(Icons.book),
      Icon(Icons.book_outlined)),
  about(
      'About.dart', AppPath.about, Icon(Icons.info), Icon(Icons.info_outline));

  const NavItem(this.label, this.url, this.icon, this.selectedIcon);
  final String url;
  final String label;
  final Icon icon;
  final Icon selectedIcon;

  static int getMatchIndex(String url) {
    return NavItem.values.indexWhere((element) => url.contains(element.url));
  }
}
