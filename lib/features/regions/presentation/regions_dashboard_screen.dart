import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/region.dart';

class RegionsDashboardScreen extends StatelessWidget {
  const RegionsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF9),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Explore cities, cultures, and stories',
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              '“Popular destinations await across Uzbekistan.”',
              style: t.bodyMedium?.copyWith(color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              readOnly: true,
              onTap: () => context.go('/places'), // later to search page
              decoration: InputDecoration(
                hintText: 'Search cities, places…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // “Popular Destinations” title + quote
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Popular Destinations',
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              'Pick a region to discover places and history.',
              style: t.bodyMedium?.copyWith(color: Colors.black54),
            ),
          ),

          // VERTICAL list of regions (stacked)
          const SizedBox(height: 6),
          for (final r in regions) _RegionTile(region: r),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RegionTile extends StatelessWidget {
  final Region region;
  const _RegionTile({required this.region});

  @override
  Widget build(BuildContext context) {
    final img = region.image ?? 'https://picsum.photos/seed/${region.id}/1200/800';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => context.go('/places/region/${region.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              CachedNetworkImage(
                imageUrl: img,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SizedBox(
                    height: 200, child: Center(child: CircularProgressIndicator())),
                errorWidget: (_, __, ___) => Container(
                  height: 200,
                  color: Colors.black12,
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.center,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        region.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
