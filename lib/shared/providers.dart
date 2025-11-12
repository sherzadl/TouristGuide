import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/places/data/place.dart';
import '../features/places/data/place_repository.dart';
import '../features/places/data/mock_place_repository.dart';

// Repository provider (mock for now)
final placeRepositoryProvider = Provider<PlaceRepository>((ref) {
  return MockPlaceRepository();
});

// Favourites (store place IDs)
class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super(<String>{});
  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
}

final favoritesProvider =
StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

// Resolve favourite Place objects for UI
final favoritePlacesProvider = FutureProvider<List<Place>>((ref) async {
  final repo = ref.read(placeRepositoryProvider);
  final favIds = ref.watch(favoritesProvider);
  final all = await repo.getPopularPlaces();
  return all.where((p) => favIds.contains(p.id)).toList();
});
