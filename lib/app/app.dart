import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_router.dart';
import 'theme.dart';

class TouristGuideApp extends StatelessWidget {
  const TouristGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tourist Guide',
      theme: buildLightTheme(GoogleFonts.interTextTheme()),
      darkTheme: buildDarkTheme(GoogleFonts.interTextTheme(ThemeData.dark().textTheme)),
      routerConfig: router,
    );
  }
}
