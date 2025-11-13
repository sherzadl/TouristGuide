import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = _categories;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Discover by Category',
            style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Find places that match your mood: history, art, nature, or local life.',
            style: t.bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 16),

          for (final c in categories) _CategoryCard(category: c),
        ],
      ),
    );
  }
}

class _Category {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  const _Category({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const _categories = <_Category>[
  _Category(
    name: 'Historical Sites',
    description: 'Madrasahs, fortresses, and ancient squares from the Silk Road era.',
    icon: Icons.account_balance_outlined,
    color: Color(0xFF2E86AB),
  ),
  _Category(
    name: 'Museums',
    description: 'Art, culture, and history under one roof.',
    icon: Icons.museum_outlined,
    color: Color(0xFF8E44AD),
  ),
  _Category(
    name: 'Theatres',
    description: 'Opera houses and cultural performances across Uzbekistan.',
    icon: Icons.theaters_outlined,
    color: Color(0xFFD35400),
  ),
  _Category(
    name: 'Parks',
    description: 'Green escapes, lakes, and family-friendly spaces.',
    icon: Icons.park_outlined,
    color: Color(0xFF27AE60),
  ),
  _Category(
    name: 'Local Markets',
    description: 'Bazaars full of spices, handicrafts, and local life.',
    icon: Icons.storefront_outlined,
    color: Color(0xFFC0392B),
  ),
];

class _CategoryCard extends StatelessWidget {
  final _Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // later: navigate to filtered places for this category
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Filtering by "${category.name}" coming soon…')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: category.color.withOpacity(0.12),
                child: Icon(category.icon, color: category.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category.name,
                        style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(
                      category.description,
                      style: t.bodyMedium?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
