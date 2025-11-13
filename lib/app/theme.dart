import 'package:flutter/material.dart';

/// Used by app.dart:
///   theme: buildLightTheme(GoogleFonts.interTextTheme()),
///   darkTheme: buildDarkTheme(GoogleFonts.interTextTheme(ThemeData.dark().textTheme)),
ThemeData buildLightTheme(TextTheme textTheme) {
  const surface = Color(0xFFF6F3EB); // soft warm background

  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF00897B), // teal-ish, close to travel / your logo
    brightness: Brightness.light,
    background: surface,
    surface: surface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: surface,
    textTheme: textTheme,

    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      indicatorColor: colorScheme.primary.withOpacity(0.12),
      iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}

ThemeData buildDarkTheme(TextTheme textTheme) {
  final base = ThemeData.dark();
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF00897B),
    brightness: Brightness.dark,
  );

  return base.copyWith(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFF101315),
    textTheme: textTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF101315),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF101315),
      indicatorColor: colorScheme.primary.withOpacity(0.3),
      iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colorScheme.primary
              : Colors.white70,
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E2427),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
