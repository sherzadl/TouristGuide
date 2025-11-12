import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/regions/presentation/regions_dashboard_screen.dart';
import '../features/regions/presentation/region_places_screen.dart';

import '../features/places/presentation/place_detail_screen.dart';
import '../features/places/presentation/favorites_screen.dart';
import '../features/places/presentation/must_visit_screen.dart';
import '../features/places/presentation/map_screen.dart';
import '../features/places/data/place.dart';

class _ScaffoldWithTabs extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithTabs({required this.child});

  static const _tabs = [
    _Tab(icon: Icons.travel_explore, label: 'Places', route: '/places'),
    _Tab(icon: Icons.favorite_border, label: 'Favourites', route: '/favourites'),
    _Tab(icon: Icons.star_border, label: 'Must Visit', route: '/mustvisit'),
    _Tab(icon: Icons.near_me, label: 'Nearby', route: '/nearby'),
  ];

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/favourites')) return 1;
    if (loc.startsWith('/mustvisit')) return 2;
    if (loc.startsWith('/nearby')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final idx = _indexFromLocation(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i) => context.go(_tabs[i].route),
        destinations: [
          for (final t in _tabs)
            NavigationDestination(icon: Icon(t.icon), label: t.label),
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

    // Bottom tabs shell
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithTabs(child: child),
      routes: [
        // PLACES (dashboard) + nested region + place detail
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
                    return PlaceDetailScreen(placeId: id, initialPlace: place);
                  },
                ),
              ],
            ),
          ],
        ),

        // FAVOURITES
        GoRoute(
          path: '/favourites',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: FavoritesScreen()),
        ),

        // MUST VISIT
        GoRoute(
          path: '/mustvisit',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: MustVisitScreen()),
        ),

        // NEARBY (map)
        GoRoute(
          path: '/nearby',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: MapScreen()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
);
