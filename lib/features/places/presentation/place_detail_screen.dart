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
            child: CachedNetworkImage(
              imageUrl: place?.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => const Center(
                child: SizedBox(width: 28, height: 28, child: CircularProgressIndicator()),
              ),
              errorWidget: (_, __, ___) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (place != null) ...[
            Text(place.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(width: 6),
                Text('${place.city}, ${place.country}'),
                const Spacer(),
                const Icon(Icons.star, size: 18),
                const SizedBox(width: 4),
                Text(place.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 12),
            Text(place.description),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Map coming soon…')),
                );
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('View on Map'),
            ),
          ],
        ],
      ),
    );
  }
}
