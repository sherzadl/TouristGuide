import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../data/place.dart';
import '../data/places_catalog.dart';
import '../../../shared/providers.dart';

class MustVisitScreen extends ConsumerWidget {
  const MustVisitScreen({super.key});

  // ✅ Tiny reasons per place (edit freely)
  // Use place.id as key.
  static const Map<String, String> _reasons = {
    'registan': 'UNESCO masterpiece of Samarkand.',
    'ark_of_bukhara': 'Historic citadel & royal fortress.',
    'khiva_ichan_qala': 'Best-preserved Silk Road city.',
    'amir_timur_square': 'Heart of modern Tashkent.',
    'chor_minor': 'Unique 4-tower madrasa.',
    'gur_emir': 'Tomb of Amir Temur & Timurid art.',
    'shah_i_zinda': 'Stunning sacred necropolis.',
    'kalyan_minaret': 'Iconic symbol of Bukhara.',
    'aidarkul_lake': 'Desert lake, epic sunsets.',
    'chimgan': 'Top mountain escape near Tashkent.',
  };

  String _reasonFor(Place p) {
    return _reasons[p.id] ?? 'A top cultural highlight in Uzbekistan.';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIds = ref.watch(favoritesProvider);

    final places =
    allPlaces.where((p) => p.isMustVisit == true).toList(growable: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Must-Visit Places'),
        centerTitle: true,
      ),
      body: places.isEmpty
          ? const Center(child: Text('No must-visit places yet.'))
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final p = places[i];
          final isFav = favIds.contains(p.id);

          return MustVisitBigCard(
            rank: i + 1,
            reason: _reasonFor(p),
            place: p,
            isFavorite: isFav,
            onFavoriteToggle: () =>
                ref.read(favoritesProvider.notifier).toggle(p.id),
            onTap: () => context.go(
              '/places/region/${p.regionId}/place/${p.id}',
              extra: p,
            ),
          );
        },
      ),
    );
  }
}

class MustVisitBigCard extends StatelessWidget {
  final int rank;
  final String reason;
  final Place place;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const MustVisitBigCard({
    super.key,
    required this.rank,
    required this.reason,
    required this.place,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  Widget _buildImage() {
    final img = place.imageUrl;

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

    return Image.asset(img, fit: BoxFit.cover);
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
            // ---------- IMAGE + RANK BADGE (BOTTOM-LEFT, GOLD) ----------
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: _buildImage(),
                  ),

                  // ✅ Rank badge moved to bottom-left + gold
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37), // gold
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.emoji_events,
                            size: 16,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Top $rank',
                            style: t.labelLarge?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ---------- INFO ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category + fav
                  Row(
                    children: [
                      // ✅ category background changed
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7DB2).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          place.category,
                          style: t.labelSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2E7DB2),
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

                  const SizedBox(height: 6),

                  // ✅ tiny reason line
                  Text(
                    reason,
                    style: t.bodySmall?.copyWith(
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // rating + city
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.orange.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: t.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(Must-visit)",
                        style: t.bodySmall?.copyWith(color: Colors.black54),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        place.city,
                        style: t.bodySmall?.copyWith(color: Colors.black87),
                      ),
                    ],
                  ),

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
