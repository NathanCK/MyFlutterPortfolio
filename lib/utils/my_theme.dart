import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerTheme extends ThemeExtension<MyDrawerTheme> {
  final Color backgroundColor;
  final Color buttonSelectedIndicatorColor;
  final ElevatedButtonThemeData buttonTheme;

  const MyDrawerTheme({
    required this.backgroundColor,
    required this.buttonSelectedIndicatorColor,
    required this.buttonTheme,
  });

  @override
  ThemeExtension<MyDrawerTheme> copyWith({
    Color? backgroundColor,
    Color? buttonSelectedIndicatorColor,
    ElevatedButtonThemeData? buttonTheme,
  }) {
    return MyDrawerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonSelectedIndicatorColor:
          buttonSelectedIndicatorColor ?? this.buttonSelectedIndicatorColor,
      buttonTheme: buttonTheme ?? this.buttonTheme,
    );
  }

  @override
  ThemeExtension<MyDrawerTheme> lerp(
      covariant ThemeExtension<MyDrawerTheme>? other, double t) {
    if (other is! MyDrawerTheme) {
      return this;
    }

    return MyDrawerTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      buttonSelectedIndicatorColor: Color.lerp(
          buttonSelectedIndicatorColor, other.buttonSelectedIndicatorColor, t)!,
      buttonTheme: buttonTheme,
    );
  }
}

final MyDrawerTheme myDrawerLightTheme = MyDrawerTheme(
    backgroundColor: const Color(0xFF1c2229),
    buttonSelectedIndicatorColor: const Color(0xFF0dd83d),
    buttonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected) ||
            states.contains(MaterialState.hovered)) {
          return const Color(0xFF363b41);
        }
        return const Color(0xFF1c2229);
      }),
      textStyle: MaterialStatePropertyAll(GoogleFonts.openSans(
          textStyle: const TextStyle(overflow: TextOverflow.ellipsis))),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
    )));

final BottomNavigationBarThemeData myBottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  elevation: 0,
  backgroundColor: const Color(0xFF1c2229),
  unselectedItemColor: Colors.white,
  selectedItemColor: const Color.fromARGB(216, 48, 241, 93),
  unselectedLabelStyle: GoogleFonts.openSans(
    color: Colors.white,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
  showUnselectedLabels: false,
  enableFeedback: true,
  unselectedIconTheme: const IconThemeData(size: 24),
  selectedIconTheme: const IconThemeData(size: 28),
);

final NavigationRailThemeData myNavigationRailThemeData =
    NavigationRailThemeData(
  backgroundColor: const Color(0xFF1c2229),
  elevation: 0,
  useIndicator: true,
  indicatorColor: const Color.fromARGB(173, 90, 90, 92),
  unselectedIconTheme: const IconThemeData(color: Colors.white),
  selectedIconTheme:
      const IconThemeData(color: Color.fromARGB(253, 2, 162, 39), shadows: [
    Shadow(color: Color.fromARGB(255, 112, 255, 146), blurRadius: 20),
  ]),
  selectedLabelTextStyle: GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 12,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
  unselectedLabelTextStyle: GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 12,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
  indicatorShape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  labelType: NavigationRailLabelType.selected,
);
// final MyDrawerTheme myDrawerDarkTheme = MyDrawerTheme(backgroundColor: const Color(value), buttonSelectedIndicatorColor: buttonSelectedIndicatorColor, buttonTheme: buttonTheme)

final lightTheme = ThemeData.light().copyWith(
  textTheme: TextTheme(bodyLarge: GoogleFonts.openSans(color: Colors.black)),
);
