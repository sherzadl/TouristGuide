import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/places/presentation/home_screen.dart';
import '../features/places/presentation/place_list_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/places/presentation/map_screen.dart';
import '../features/places/presentation/favorites_screen.dart';
import '../features/places/data/place.dart';

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  static const _tabs = [
    _NavItem(label: 'Home', icon: Icons.home_outlined, route: '/'),
    _NavItem(label: 'Explore', icon: Icons.travel_explore, route: '/explore'),
    _NavItem(label: 'Map', icon: Icons.map_outlined, route: '/map'),
    _NavItem(label: 'Favorites', icon: Icons.favorite_border, route: '/favorites'),
  ];

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/explore')) return 1;
    if (loc.startsWith('/map')) return 2;
    if (loc.startsWith('/favorites')) return 3;
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

class _NavItem {
  final String label;
  final IconData icon;
  final String route;
  const _NavItem({required this.label, required this.icon, required this.route});
}

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/explore',
          name: 'places',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: PlaceListScreen()),
          routes: [
            GoRoute(
              path: ':id',
              name: 'placeDetail',
              builder: (context, state) {
                final place = state.extra as Place?;
                final id = state.pathParameters['id']!;
                return PlaceDetailScreen(placeId: id, initialPlace: place);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/map',
          name: 'map',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: MapScreen()),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          pageBuilder: (context, state) =>
          const NoTransitionPage(child: FavoritesScreen()),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Route error: ${state.error}'))),
);
