import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/place.dart';

class PlaceBigCard extends StatelessWidget {
  final Place place;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const PlaceBigCard({
    super.key,
    required this.place,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  Widget _buildImage() {
    final img = place.imageUrl;

    // If it's a web link → CachedNetworkImage
    if (img.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(color: Colors.grey.shade200),
        errorWidget: (_, __, ___) => Container(
          color: Colors.grey.shade200,
          child: const Icon(Icons.image_not_supported),
        ),
      );
    }

    // Otherwise treat as asset path
    return Image.asset(
      img,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- IMAGE ----------
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(18)),
              child: SizedBox(
                height: 190,
                width: double.infinity,
                child: _buildImage(),
              ),
            ),

            // ---------- INFO ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category + fav button
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          place.category,
                          style: t.labelSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: onFavoriteToggle,
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.redAccent
                              : Colors.black45,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // title
                  Text(
                    place.name,
                    style: t.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // rating + city
                  Row(
                    children: [
                      Icon(Icons.star,
                          size: 18, color: Colors.orange.shade600),
                      const SizedBox(width: 4),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: t.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(Popular)",
                        style: t.bodySmall?.copyWith(color: Colors.black54),
                      ),
                      const Spacer(),
                      Icon(Icons.location_on_outlined,
                          size: 18, color: Colors.black45),
                      const SizedBox(width: 2),
                      Text(
                        place.city,
                        style: t.bodySmall?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),

                  // optional visiting hours
                  if (place.visitingHours != null &&
                      place.visitingHours!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      "Hours: ${place.visitingHours}",
                      style: t.bodySmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
