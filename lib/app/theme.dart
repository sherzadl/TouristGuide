import 'package:flutter/material.dart';

ThemeData buildLightTheme(TextTheme textTheme) {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2F7BFF),
    brightness: Brightness.light,
  );
  return base.copyWith(
    textTheme: textTheme,
    cardTheme: const CardThemeData(
      margin: EdgeInsets.all(8),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
  );
}

ThemeData buildDarkTheme(TextTheme textTheme) {
  final base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2F7BFF),
    brightness: Brightness.dark,
  );
  return base.copyWith(
    textTheme: textTheme,
    cardTheme: const CardThemeData(
      margin: EdgeInsets.all(8),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    ),
  );
}
