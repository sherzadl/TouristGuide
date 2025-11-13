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
            child: Text(
              'Explore cities, cultures, and stories',
              style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
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
              onTap: () => context.go('/places'),
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Popular Destinations',
              style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              'Pick a region to discover places and history.',
              style: t.bodyMedium?.copyWith(color: Colors.black54),
            ),
          ),

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

  Widget _buildBackgroundImage() {
    final img = region.image;

    // If no image specified → fallback
    if (img == null || img.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Center(
          child: Icon(Icons.landscape_outlined, size: 40, color: Colors.black45),
        ),
      );
    }

    // If it's an asset path
    if (img.startsWith('assets/')) {
      return Image.asset(
        img,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // Otherwise treat as network URL
    return CachedNetworkImage(
      imageUrl: img,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (_, __) => const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (_, __, ___) => Container(
        height: 200,
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => context.go('/places/region/${region.id}'),
        borderRadius: BorderRadius.circular(18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _buildBackgroundImage(),
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
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
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.white),
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
