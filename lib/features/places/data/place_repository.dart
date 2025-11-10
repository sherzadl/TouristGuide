import 'place.dart';

abstract class PlaceRepository {
  Future<List<Place>> getPopularPlaces();
  Future<Place?> getPlaceById(String id);
}
