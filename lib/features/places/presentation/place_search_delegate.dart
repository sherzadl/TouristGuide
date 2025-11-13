import 'package:flutter/material.dart';

import '../data/place.dart';
import '../data/places_catalog.dart';
import 'widgets/place_card.dart';

/// Search delegate used from the Places dashboard.
/// It searches in place name, city and region id.
class PlaceSearchDelegate extends SearchDelegate<Place?> {
  PlaceSearchDelegate();

  @override
  String get searchFieldLabel => 'Search places, cities…';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  List<Place> _filterPlaces() {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return [];

    return allPlaces.where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.city.toLowerCase().contains(q) ||
          p.regionId.toLowerCase().contains(q);
    }).toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _filterPlaces();
    if (results.isEmpty) {
      return const Center(child: Text('No places found.'));
    }
    return _buildList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Search by place name, city or region.'),
      );
    }
    final results = _filterPlaces();
    if (results.isEmpty) {
      return const Center(child: Text('No places found.'));
    }
    return _buildList(results);
  }

  Widget _buildList(List<Place> results) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final place = results[index];
        return PlaceCard(
          place: place,
          onTap: () => close(context, place),
        );
      },
    );
  }
}
