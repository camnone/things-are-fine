import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.green,
    showUnselectedLabels: false,
    selectedLabelStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  ),
  colorScheme:
      ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.dark),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
  ),
);

final lightTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.green,
    showUnselectedLabels: false,
    selectedLabelStyle: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue, brightness: Brightness.light),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
  ),
);
