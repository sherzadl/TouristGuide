import 'dart:async';

import 'place.dart';
import 'place_repository.dart';
import 'places_catalog.dart'; // contains: final List<Place> allPlaces = [...]

class MockPlaceRepository implements PlaceRepository {
  /// Acts as our in-memory "database" of places.
  final List<Place> _data = allPlaces;

  @override
  Future<List<Place>> getPopularPlaces() async {
    // small delay to mimic network/API
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // for now: sort by rating and return them all
    final list = List<Place>.from(_data);
    list.sort((a, b) => b.rating.compareTo(a.rating));
    return list;
  }

  @override
  Future<Place?> getPlaceById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    try {
      return _data.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Extra helper used by RegionPlacesScreen to show places in a region.
  Future<List<Place>> getPlacesByRegion(String regionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _data.where((p) => p.regionId == regionId).toList();
  }
}
