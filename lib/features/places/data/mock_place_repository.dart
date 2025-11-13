import 'dart:async';

import 'place.dart';
import 'place_repository.dart';
import 'places_catalog.dart';

class MockPlaceRepository implements PlaceRepository {
  final List<Place> _data = allPlaces;

  @override
  Future<List<Place>> getPopularPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
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

  Future<List<Place>> getPlacesByRegion(String regionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _data.where((p) => p.regionId == regionId).toList();
  }
}
