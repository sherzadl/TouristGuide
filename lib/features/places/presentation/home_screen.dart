import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tourist Guide')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => context.goNamed('places'),
          icon: const Icon(Icons.travel_explore),
          label: const Text('Explore Places'),
        ),
      ),
    );
  }
}
