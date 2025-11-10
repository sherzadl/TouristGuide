import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tourist Guide')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar (navigates to Explore with query later)
          TextField(
            readOnly: true,
            onTap: () => context.go('/explore'),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search places, cities…',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Categories row (dummy nav to Explore for now)
          Text('Categories', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _CategoryChip(icon: Icons.account_balance, label: 'Historical'),
              _CategoryChip(icon: Icons.museum_outlined, label: 'Museums'),
              _CategoryChip(icon: Icons.theaters_outlined, label: 'Theatres'),
              _CategoryChip(icon: Icons.park_outlined, label: 'Parks'),
              _CategoryChip(icon: Icons.storefront_outlined, label: 'Markets'),
            ],
          ),

          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.go('/explore'),
            icon: const Icon(Icons.travel_explore),
            label: const Text('Browse Popular Places'),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CategoryChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: () => context.go('/explore'),
    );
  }
}
