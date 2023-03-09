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
  selectedItemColor: Colors.white,
  unselectedLabelStyle: GoogleFonts.openSans(
    color: Colors.white,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
  selectedLabelStyle: GoogleFonts.openSans(
    color: Colors.white,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
  showUnselectedLabels: false,
  unselectedIconTheme: const IconThemeData(size: 24),
  selectedIconTheme: const IconThemeData(
    size: 28,
  ),
);

final NavigationRailThemeData myNavigationRailThemeData =
    NavigationRailThemeData(
  backgroundColor: const Color(0xFF1c2229),
  elevation: 0,
  useIndicator: true,
  indicatorColor: const Color.fromARGB(173, 90, 90, 92),
  unselectedIconTheme: const IconThemeData(color: Colors.white),
  selectedIconTheme: const IconThemeData(
    color: Color.fromARGB(253, 2, 162, 39),
  ),
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

final lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      highlightColor: Colors.transparent,
    ),
  ),
  textTheme: TextTheme(bodyLarge: GoogleFonts.openSans(color: Colors.black)),
);
