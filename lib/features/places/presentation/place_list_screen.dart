import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../places/data/place.dart';
import '../../places/data/place_repository.dart';
import '../../../shared/providers.dart';
import 'widgets/place_card.dart';

class PlaceListScreen extends ConsumerWidget {
  const PlaceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(placeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular Places')),
      body: FutureBuilder<List<Place>>(
        future: repo.getPopularPlaces(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final places = snap.data!;
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (_, i) => PlaceCard(
              place: places[i],
              onTap: () => context.goNamed('placeDetail', pathParameters: {'id': places[i].id}, extra: places[i]),
            ),
          );
        },
      ),
    );
  }
}
