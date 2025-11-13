import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            'See all places in Uzbekistan that match each type of attraction.',
            style: t.bodyMedium?.copyWith(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          for (final c in _categories) _CategoryCard(category: c),
        ],
      ),
    );
  }
}

class _Category {
  final String id; // used in route (e.g. "historical")
  final String label; // must match Place.category
  final String description;
  final IconData icon;
  final Color color;

  const _Category({
    required this.id,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });
}

const _categories = <_Category>[
  _Category(
    id: 'historical',
    label: 'Historical Sites',
    description: 'Fortresses, madrasahs, mausoleums and old towns.',
    icon: Icons.account_balance_outlined,
    color: Color(0xFF2E86AB),
  ),
  _Category(
    id: 'museums',
    label: 'Museums',
    description: 'Art, archaeology and local history collections.',
    icon: Icons.museum_outlined,
    color: Color(0xFF8E44AD),
  ),
  _Category(
    id: 'parks',
    label: 'Parks',
    description: 'Mountains, lakes and city parks.',
    icon: Icons.park_outlined,
    color: Color(0xFF27AE60),
  ),
  _Category(
    id: 'markets',
    label: 'Local Markets',
    description: 'Bazaars full of food, spices and daily life.',
    icon: Icons.storefront_outlined,
    color: Color(0xFFC0392B),
  ),
  _Category(
    id: 'theatres',
    label: 'Theatres',
    description: 'Opera, ballet and cultural performances.',
    icon: Icons.theaters_outlined,
    color: Color(0xFFD35400),
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
          context.go('/categories/${category.id}');
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
                    Text(
                      category.label,
                      style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
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
