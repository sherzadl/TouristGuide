import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1600), () {
      if (mounted) context.go('/places'); // go to Places tab (dashboard)
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0E8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/branding/logo_1024.png', width: 140, height: 140),
              const SizedBox(height: 16),
              Text('UZBEKISTAN', style: t.headlineSmall?.copyWith(
                letterSpacing: 1.4, fontWeight: FontWeight.w800, color: const Color(0xFF0A6A66),
              )),
              const SizedBox(height: 6),
              Text(
                '“From Registan to the Aral sands — explore your own story.”',
                style: t.bodyMedium?.copyWith(color: const Color(0xFF56706E)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
