import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback? onTap;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const PlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: place.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator())),
                errorWidget: (_, __, ___) => Container(
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(place.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                          color: isFavorite ? Colors.red : null,
                          onPressed: onFavoriteToggle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text('${place.city}, ${place.country}',
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, size: 16),
                        const SizedBox(width: 2),
                        Text(place.rating.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
