class Place {
  final String id;
  final String name;
  final String city;
  final String regionId; // e.g. 'samarkand', 'bukhara', 'karakalpakstan'
  final String country;
  final String description;

  /// One of:
  /// 'Historical Sites', 'Museums', 'Theatres', 'Parks', 'Local Markets'
  final String category;

  /// Asset or network image. In our app we mostly use assets:
  /// e.g. 'assets/places/samarkand/registan_1.jpg'
  final String imageUrl;

  final double rating;

  /// Coordinates for Google Maps
  final double? latitude;
  final double? longitude;

  /// Extra info for detail screen
  final String? visitingHours;
  final String? ticketInfo;
  final String? bestSeason;
  final String? tips;

  /// Used by Must-Visit screen
  final bool isMustVisit;

  const Place({
    required this.id,
    required this.name,
    required this.city,
    required this.regionId,
    this.country = 'Uzbekistan',
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
    this.latitude,
    this.longitude,
    this.visitingHours,
    this.ticketInfo,
    this.bestSeason,
    this.tips,
    this.isMustVisit = false,
  });
}
