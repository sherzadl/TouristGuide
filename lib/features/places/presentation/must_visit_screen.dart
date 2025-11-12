import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers.dart';
import '../data/place.dart';
import 'widgets/place_card.dart';

class MustVisitScreen extends ConsumerWidget {
  const MustVisitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Must Visit')),
      body: FutureBuilder<List<Place>>(
        future: _loadMustVisit(ref),
        builder: (context, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final places = snap.data!;
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: places.length,
            itemBuilder: (_, i) => PlaceCard(
              place: places[i],
              isFavorite: favIds.contains(places[i].id),
              onFavoriteToggle: () =>
                  ref.read(favoritesProvider.notifier).toggle(places[i].id),
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        },
      ),
    );
  }

  Future<List<Place>> _loadMustVisit(WidgetRef ref) async {
    // For now, pick 3 well-known ones (matches mock data IDs)
    final repo = ref.read(placeRepositoryProvider);
    final all = await repo.getPopularPlaces();
    final ids = {'1', '2', '3'}; // Registan, Itchan Kala, Ark Fortress
    return all.where((p) => ids.contains(p.id)).toList();
  }
}
