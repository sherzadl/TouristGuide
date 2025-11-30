import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // Outer scroll view: if height is small, you can scroll
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'What do you want to explore?',
                      style: t.titleLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Tap a category to see all matching places across Uzbekistan.',
                        style: t.bodyMedium?.copyWith(color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grid of 6 categories – grid itself does NOT scroll
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _categories.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (_, i) =>
                            _CategoryCard(category: _categories[i]),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ----------------- MODEL -----------------

class _Category {
  final String id;
  final String label;
  final String gifAsset; // animated gif path
  final Color color;

  const _Category({
    required this.id,
    required this.label,
    required this.gifAsset,
    required this.color,
  });
}

const _categories = <_Category>[
  _Category(
    id: 'historical',
    label: 'Historical Sites',
    gifAsset: 'assets/gifs/historical.gif',
    color: Color(0xFF2E86AB),
  ),
  _Category(
    id: 'museums',
    label: 'Museums',
    gifAsset: 'assets/gifs/museum.gif',
    color: Color(0xFF8E44AD),
  ),
  _Category(
    id: 'parks',
    label: 'Parks',
    gifAsset: 'assets/gifs/parks.gif',
    color: Color(0xFF27AE60),
  ),
  _Category(
    id: 'mountains',
    label: 'Mountains',
    gifAsset: 'assets/gifs/mountains.gif',
    color: Color(0xFF16A085),
  ),
  _Category(
    id: 'markets',
    label: 'Local Markets',
    gifAsset: 'assets/gifs/localmarkets.gif',
    color: Color(0xFFC0392B),
  ),
  _Category(
    id: 'theatres',
    label: 'Theatres',
    gifAsset: 'assets/gifs/theatre.gif',
    color: Color(0xFFD35400),
  ),
];

// ----------------- CARD -----------------

class _CategoryCard extends StatelessWidget {
  final _Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => context.go('/categories/${category.id}'),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.18),
              category.color.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: category.color.withOpacity(0.45),
            width: 1.3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _BigGifIcon(
                gifPath: category.gifAsset,
                color: category.color,
              ),
              const SizedBox(height: 10),
              Text(
                category.label,
                style: t.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------- BIG GIF ICON (FULL CONTAINER) -----------------

class _BigGifIcon extends StatelessWidget {
  final String gifPath;
  final Color color;

  const _BigGifIcon({
    required this.gifPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          gifPath,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.category,
            size: 54,
            color: color.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
