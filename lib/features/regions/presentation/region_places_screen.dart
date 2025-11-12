import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/region.dart';
import '../../places/data/place.dart';
import '../../places/data/mock_place_repository.dart';
import '../../../shared/providers.dart';
import '../../places/presentation/widgets/place_card.dart';

class RegionPlacesScreen extends ConsumerWidget {
  final String regionId;
  const RegionPlacesScreen({super.key, required this.regionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(placeRepositoryProvider) as MockPlaceRepository;
    final favIds = ref.watch(favoritesProvider);
    final regionName = regions.firstWhere((r) => r.id == regionId).name;

    return Scaffold(
      appBar: AppBar(title: Text(regionName)),
      body: FutureBuilder<List<Place>>(
        future: repo.getPlacesByRegion(regionId),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final places = snap.data!;
          if (places.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('No places added for $regionName yet.'),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: places.length,
            itemBuilder: (_, i) {
              final p = places[i];
              final isFav = favIds.contains(p.id);
              return PlaceCard(
                place: p,
                isFavorite: isFav,
                onFavoriteToggle: () => ref.read(favoritesProvider.notifier).toggle(p.id),
                onTap: () => context.go('/places/region/$regionId/place/${p.id}', extra: p),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }
}
