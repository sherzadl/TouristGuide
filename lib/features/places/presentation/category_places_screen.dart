import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/place.dart';
import '../data/places_catalog.dart';
import '../../../shared/providers.dart';
import 'widgets/place_big_card.dart';

class CategoryPlacesScreen extends ConsumerWidget {
  final String categoryId; // from route: historical/museums/parks/mountains/markets/theatres

  const CategoryPlacesScreen({
    super.key,
    required this.categoryId,
  });

  // Map route id -> visible label (for AppBar only)
  String _labelForCategory(String id) {
    switch (id) {
      case 'historical':
        return 'Historical Sites';
      case 'museums':
        return 'Museums';
      case 'parks':
        return 'Parks';
      case 'mountains':
        return 'Mountains';
      case 'markets':
        return 'Local Markets';
      case 'theatres':
        return 'Theatres';
      default:
        return 'Places';
    }
  }

  // Normalize strings to compare safely
  String _norm(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'[\s\-_]'), '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoritesProvider);
    final label = _labelForCategory(categoryId);

    // ✅ Filter from ALL places, not only popular
    final places = allPlaces.where((p) {
      // match either by exact label OR by normalized id
      final c = p.category ?? '';
      return _norm(c) == _norm(label) || _norm(c) == _norm(categoryId);
    }).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        centerTitle: true,
      ),
      body: places.isEmpty
          ? const Center(child: Text('No places in this category yet.'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final place = places[index];
          final isFav = favIds.contains(place.id);

          return PlaceBigCard(
            place: place,
            isFavorite: isFav,
            onFavoriteToggle: () =>
                ref.read(favoritesProvider.notifier).toggle(place.id),
            onTap: () {
              context.go(
                '/places/region/${place.regionId}/place/${place.id}',
                extra: place,
              );
            },
          );
        },
      ),
    );
  }
}
