import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/splash/presentation/splash_screen.dart';
import '../features/regions/presentation/regions_dashboard_screen.dart';
import '../features/regions/presentation/region_places_screen.dart';

import '../features/places/presentation/place_list_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/places/presentation/favorites_screen.dart';
import '../features/places/presentation/map_screen.dart';      // will be "Nearby"
import '../features/places/data/place.dart';
import '../features/places/presentation/bookings_screen.dart'; // we'll add this file below

class _ScaffoldWithTabs extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithTabs({required this.child});

  static const _tabs = [
    _Tab(icon: Icons.travel_explore, label: 'Places', route: '/explore'),
    _Tab(icon: Icons.favorite_border, label: 'Favorites', route: '/favorites'),
    _Tab(icon: Icons.near_me, label: 'Nearby', route: '/nearby'),
    _Tab(icon: Icons.calendar_month, label: 'Bookings', route: '/bookings'),
  ];

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/favorites')) return 1;
    if (loc.startsWith('/nearby')) return 2;
    if (loc.startsWith('/bookings')) return 3;
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
          for (final t in _tabs) NavigationDestination(icon: Icon(t.icon), label: t.label),
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
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Dashboard (regions) lives outside the Shell so it's the "home" when app opens
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const RegionsDashboardScreen(),
      routes: [
        GoRoute(
          path: 'region/:regionId',
          name: 'regionPlaces',
          builder: (context, state) {
            final regionId = state.pathParameters['regionId']!;
            return RegionPlacesScreen(regionId: regionId);
          },
          routes: [
            GoRoute(
              path: 'place/:id',
              name: 'placeDetail',
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

    // Shell with bottom tabs
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithTabs(child: child),
      routes: [
        // Places tab (reuse your list)
        GoRoute(
          path: '/explore',
          name: 'places',
          pageBuilder: (context, state) => const NoTransitionPage(child: PlaceListScreen()),
        ),
        // Favorites tab
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          pageBuilder: (context, state) => const NoTransitionPage(child: FavoritesScreen()),
        ),
        // Nearby tab (use MapScreen)
        GoRoute(
          path: '/nearby',
          name: 'nearby',
          pageBuilder: (context, state) => const NoTransitionPage(child: MapScreen()),
        ),
        // Bookings tab (placeholder screen we add below)
        GoRoute(
          path: '/bookings',
          name: 'bookings',
          pageBuilder: (context, state) => const NoTransitionPage(child: BookingsScreen()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Route error: ${state.error}')),
  ),
);
