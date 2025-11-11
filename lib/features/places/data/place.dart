// lib/features/places/data/place.dart
class Place {
  final String id;
  final String name;
  final String city;
  final String country;
  final String description;
  final double rating;
  final String imageUrl;
  final double? lat;
  final double? lng;
  final String regionId; // required for region filtering

  const Place({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.description,
    required this.rating,
    required this.imageUrl,
    this.lat,
    this.lng,
    required this.regionId,
  });
}
