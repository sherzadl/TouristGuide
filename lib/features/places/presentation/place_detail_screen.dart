import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../data/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String placeId;
  final Place? initialPlace;
  const PlaceDetailScreen({super.key, required this.placeId, this.initialPlace});

  @override
  Widget build(BuildContext context) {
    final place = initialPlace;
    return Scaffold(
      appBar: AppBar(title: Text(place?.name ?? 'Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(imageUrl: place?.imageUrl ?? '', fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(place?.name ?? '', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              const SizedBox(width: 6),
              Text('${place?.city}, ${place?.country}'),
              const Spacer(),
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 4),
              Text((place?.rating ?? 0).toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 12),
          Text(place?.description ?? ''),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              // placeholder for Maps; we'll wire Google Maps later.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Map coming soon…')),
              );
            },
            icon: const Icon(Icons.map_outlined),
            label: const Text('View on Map'),
          ),
        ],
      ),
    );
  }
}
