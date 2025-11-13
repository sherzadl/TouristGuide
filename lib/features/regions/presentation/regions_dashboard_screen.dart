import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/region.dart';
import '../../places/data/place.dart';
import '../../places/presentation/place_search_delegate.dart';

class RegionsDashboardScreen extends StatelessWidget {
  const RegionsDashboardScreen({super.key});

  Future<void> _openSearch(BuildContext context) async {
    final result = await showSearch<Place?>(
      context: context,
      delegate: PlaceSearchDelegate(),
    );

    if (result != null && context.mounted) {
      context.go(
        '/places/region/${result.regionId}/place/${result.id}',
        extra: result,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      // background comes from global theme
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            // ---------- HEADER ----------
            Column(
              children: [
                Text(
                  'Explore Uzbekistan',
                  style: t.titleLarge?.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Find history, culture and nature\nin every region of the country.',
                  style: t.bodyMedium?.copyWith(
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ---------- SEARCH BAR ----------
            GestureDetector(
              onTap: () => _openSearch(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search places by name',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 0,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ---------- SECTION TITLE ----------
            Text(
              'Popular Destinations',
              style: t.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Choose a region to see the main sights, maps and travel tips.',
              style: t.bodyMedium?.copyWith(color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // ---------- REGIONS LIST ----------
            for (final r in regions) _RegionTile(region: r),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _RegionTile extends StatelessWidget {
  final Region region;
  const _RegionTile({required this.region});

  Widget _buildBackgroundImage() {
    final img = region.image;

    if (img == null || img.isEmpty) {
      return Container(
        height: 200,
        color: Colors.grey.shade300,
        child: const Center(
          child: Icon(
            Icons.landscape_outlined,
            size: 40,
            color: Colors.black45,
          ),
        ),
      );
    }

    if (img.startsWith('assets/')) {
      return Image.asset(
        img,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    // Fallback – should not really happen now.
    return Image.asset(
      img,
      height: 200,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white,
                    ),
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
