import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/providers.dart';
import '../data/place.dart';
import 'widgets/place_card.dart';

class CategoryPlacesScreen extends ConsumerWidget {
  final String categoryId; // "historical", "museums", etc.

  const CategoryPlacesScreen({
    super.key,
    required this.categoryId,
  });

  String _labelForCategory(String id) {
    switch (id) {
      case 'historical':
        return 'Historical Sites';
      case 'museums':
        return 'Museums';
      case 'parks':
        return 'Parks';
      case 'mountains':
        return 'Mountains';       // 👈 add this
      case 'markets':
        return 'Local Markets';
      case 'theatres':
        return 'Theatres';
      default:
        return id;
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(placeRepositoryProvider);
    final label = _labelForCategory(categoryId);

    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: FutureBuilder<List<Place>>(
        future: repo.getPopularPlaces(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final all = snapshot.data!;
          final places = all
              .where((p) => p.category == label)
              .toList()
            ..sort((a, b) => b.rating.compareTo(a.rating));

          if (places.isEmpty) {
            return Center(
              child: Text('No places in this category yet.'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: places.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final place = places[index];
              return PlaceCard(
                place: place,
                onTap: () {
                  context.go(
                    '/places/region/${place.regionId}/place/${place.id}',
                    extra: place,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
