import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/region.dart';

class RegionsDashboardScreen extends StatelessWidget {
  const RegionsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: const Text('Uzbekistan Tourist Guide'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1582623690729-6c8f1e803c05?q=80&w=1600&auto=format&fit=crop',
                    height: 180, width: double.infinity, fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter, end: Alignment.center,
                          colors: [Colors.black.withOpacity(.55), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16, bottom: 16, right: 16,
                    child: Text('Free Your Journey',
                        style: t.headlineSmall?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              readOnly: true,
              onTap: () => context.go('/explore'),
              decoration: InputDecoration(
                hintText: 'Explore cities, places, and tours',
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Popular Destinations',
                style: t.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _RegionGrid(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RegionGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: regions.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .95),
      itemBuilder: (_, i) => _RegionCard(region: regions[i]),
    );
  }
}

class _RegionCard extends StatelessWidget {
  final Region region;
  const _RegionCard({required this.region});

  @override
  Widget build(BuildContext context) {
    final img = region.image ??
        'https://images.unsplash.com/photo-1595436252086-796adb0f34a1?q=80&w=1200&auto=format&fit=crop';

    return Card(
      elevation: 1.5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: InkWell(
        onTap: () => context.go('/region/${region.id}'),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(img, fit: BoxFit.cover),
            Positioned(
              bottom: 10, left: 10, right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.45),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        // use region.name
                        '',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white),
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
