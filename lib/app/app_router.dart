import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/places/presentation/home_screen.dart';
import '../features/places/presentation/place_list_screen.dart';
import '../features/places/presentation/place_detail_screen.dart';
import '../features/places/data/place.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'places',
          name: 'places',
          builder: (context, state) => const PlaceListScreen(),
          routes: [
            GoRoute(
              path: ':id',
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
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text('Route error: ${state.error}')),
  ),
);
