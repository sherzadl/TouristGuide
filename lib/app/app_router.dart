import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../shared/theme_provider.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/regions/presentation/regions_dashboard_screen.dart';
import '../features/regions/presentation/region_places_screen.dart';

import '../features/places/presentation/place_detail_screen.dart';
import '../features/places/presentation/favorites_screen.dart';
import '../features/places/presentation/must_visit_screen.dart';
import '../features/places/presentation/map_screen.dart';
import '../features/places/presentation/categories_screen.dart';
import '../features/places/presentation/category_places_screen.dart';

import '../features/places/data/place.dart';

class _ScaffoldWithTabs extends ConsumerWidget {
  final Widget child;
  const _ScaffoldWithTabs({required this.child});

  static const _tabs = [
    _Tab(icon: Icons.travel_explore, label: 'Places', route: '/places'),
    _Tab(icon: Icons.category_outlined, label: 'Categories', route: '/categories'),
    _Tab(icon: Icons.near_me, label: 'Nearby', route: '/nearby'),
    _Tab(icon: Icons.star_border, label: 'Must Visit', route: '/mustvisit'),
    _Tab(icon: Icons.favorite_border, label: 'Favourites', route: '/favourites'),
  ];

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/categories')) return 1;
    if (loc.startsWith('/nearby')) return 2;
    if (loc.startsWith('/mustvisit')) return 3;
    if (loc.startsWith('/favourites')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = _indexFromLocation(context);

    final mode = ref.watch(themeModeProvider);
    final isDark = mode == ThemeMode.dark;

    return Scaffold(
      // ✅ Put child + top toggle in a Stack
      body: Stack(
        children: [
          child,

          // ✅ Small top-right toggle (global)
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 6, right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () =>
                        ref.read(themeModeProvider.notifier).toggle(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.85),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.12),
                          ),
                        ],
                      ),
                      child: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i) => context.go(_tabs[i].route),
        destinations: [
          for (final t in _tabs)
            NavigationDestination(
              icon: Icon(t.icon),
              label: t.label,
              tooltip: '',
            ),
        ],
      ),
    );
  }
}


class _Tab {
  final IconData icon;
  final String label;
  final String route;
  const _Tab({required this.icon, required this.label, required this.route});
}

final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithTabs(child: child),
      routes: [
        // PLACES + nested region + place details
        GoRoute(
          path: '/places',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: RegionsDashboardScreen()),
          routes: [
            GoRoute(
              path: 'region/:regionId',
              builder: (context, state) {
                final id = state.pathParameters['regionId']!;
                return RegionPlacesScreen(regionId: id);
              },
              routes: [
                GoRoute(
                  path: 'place/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    final place = state.extra as Place?;
                    return PlaceDetailScreen(
                      placeId: id,
                      initialPlace: place,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // CATEGORIES + category places
        GoRoute(
          path: '/categories',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: CategoriesScreen()),
          routes: [
            GoRoute(
              path: ':categoryId',
              builder: (context, state) {
                final id = state.pathParameters['categoryId']!;
                return CategoryPlacesScreen(categoryId: id);
              },
            ),
          ],
        ),

        // NEARBY
        GoRoute(
          path: '/nearby',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: MapScreen()),
        ),

        // MUST VISIT
        GoRoute(
          path: '/mustvisit',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: MustVisitScreen()),
        ),

        // FAVOURITES
        GoRoute(
          path: '/favourites',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: FavoritesScreen()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
);
