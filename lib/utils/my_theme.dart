import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawerTheme extends ThemeExtension<MyDrawerTheme> {
  final Color backgroundColor;
  final Color buttonSelectedIndicatorColor;
  final ElevatedButtonThemeData buttonTheme;
  final TextStyle labelStyle;

  const MyDrawerTheme({
    required this.backgroundColor,
    required this.buttonSelectedIndicatorColor,
    required this.buttonTheme,
    required this.labelStyle,
  });

  @override
  ThemeExtension<MyDrawerTheme> copyWith({
    Color? backgroundColor,
    Color? buttonSelectedIndicatorColor,
    ElevatedButtonThemeData? buttonTheme,
    TextStyle? labelStyle,
  }) {
    return MyDrawerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      buttonSelectedIndicatorColor:
          buttonSelectedIndicatorColor ?? this.buttonSelectedIndicatorColor,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      labelStyle: labelStyle ?? this.labelStyle,
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
      labelStyle: labelStyle.merge(other.labelStyle),
    );
  }
}

final MyDrawerTheme myDrawerLightTheme = MyDrawerTheme(
  backgroundColor: const Color(0xFF1c2229),
  buttonSelectedIndicatorColor: const Color(0xFF0dd83d),
  buttonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      iconColor: const MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected) ||
            states.contains(MaterialState.hovered)) {
          return const Color(0xFF363b41);
        }
        return const Color(0xFF1c2229);
      }),
      padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
    ),
  ),
  labelStyle: GoogleFonts.openSans(
    color: Colors.white,
    textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
  ),
);

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
  primaryTextTheme: TextTheme(
    displayLarge: GoogleFonts.aBeeZee(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: GoogleFonts.aBeeZee(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall:
        GoogleFonts.aBeeZee(fontSize: 48, fontWeight: FontWeight.w400),
    headlineMedium: GoogleFonts.aBeeZee(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineSmall:
        GoogleFonts.aBeeZee(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: GoogleFonts.aBeeZee(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleMedium: GoogleFonts.aBeeZee(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleSmall: GoogleFonts.aBeeZee(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    bodySmall: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelSmall: GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.aBeeZee(
        fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: GoogleFonts.aBeeZee(
        fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall:
        GoogleFonts.aBeeZee(fontSize: 48, fontWeight: FontWeight.w400),
    headlineMedium: GoogleFonts.aBeeZee(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineSmall:
        GoogleFonts.aBeeZee(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: GoogleFonts.aBeeZee(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleMedium: GoogleFonts.aBeeZee(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleSmall: GoogleFonts.aBeeZee(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    bodySmall: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelSmall: GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      highlightColor: Colors.transparent,
    ),
  ),
);
