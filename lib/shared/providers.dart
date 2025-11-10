import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/places/data/place_repository.dart';
import '../features/places/data/mock_place_repository.dart';

final placeRepositoryProvider = Provider<PlaceRepository>((ref) => MockPlaceRepository());
