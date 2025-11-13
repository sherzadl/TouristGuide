class Place {
  final String id;
  final String name;
  final String city;
  final String country;
  final String description; // can be long text
  final double rating;
  final String imageUrl; // can be asset path like 'assets/places/...'
  final double? lat;
  final double? lng;
  final String regionId;

  // extra optional fields for detailed info
  final String? visitingHours;
  final String? ticketInfo;
  final String? bestSeason;
  final String? tips;

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
    this.visitingHours,
    this.ticketInfo,
    this.bestSeason,
    this.tips,
  });
}
