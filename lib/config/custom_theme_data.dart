import 'package:flutter/material.dart';

final customLightThemeData = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(
      primary: Colors.deepPurple,
      secondary: const Color(0xFF719BAD),
    ),
    scaffoldBackgroundColor: const Color(0xFFE5EAEE),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 24,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF444444),
    ),
    dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFF444444),
      ),
      contentTextStyle: TextStyle(
        color: Color(0xFF777777),
      )),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xFF444444),
        fontSize: 20,
      ),
      bodySmall: TextStyle(
        color: Color(0xFF777777),
        fontSize: 16,
      ),
      titleMedium: TextStyle(
        color: Color(0xFF444444),
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        color: Color(0xFF777777),
        fontSize: 16,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ));

final customDarkThemeData = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: const Color(0xFF8A68C4),
    secondary: const Color(0xFF719BAD),
  ),
  scaffoldBackgroundColor: const Color(0xFF141920),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF8A68C4),
    titleTextStyle: TextStyle(
      fontSize: 24,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFE6E6E6),
  ),
  dialogTheme: const DialogTheme(
      titleTextStyle: TextStyle(
        color: Color(0xFFE6E6E6),
      ),
      contentTextStyle: TextStyle(
        color: Color(0xFFC0C0C0),
      ),),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Color(0xFFE6E6E6),
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: Color(0xFFC0C0C0),
      fontSize: 18,
    ),
  ),
);
