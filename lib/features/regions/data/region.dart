class Region {
  final String id;
  final String name;
  final String? image; // asset path for cover image

  const Region({
    required this.id,
    required this.name,
    this.image,
  });
}

/// All regions of Uzbekistan used in the app.
/// Karakalpakstan first.
const List<Region> regions = [
  Region(
    id: 'karakalpakstan',
    name: 'Karakalpakstan',
    image: 'assets/regions/karakalpakstan_cover.png',
  ),
  Region(
    id: 'bukhara',
    name: 'Bukhara',
    image: 'assets/regions/bukhara_cover.jpg',
  ),
  Region(
    id: 'samarkand',
    name: 'Samarkand',
    image: 'assets/regions/samarkand_cover.jpg',
  ),
  Region(
    id: 'khorezm',
    name: 'Khorezm (Khiva)',
  ),
  Region(
    id: 'tashkent-city',
    name: 'Tashkent City',
  ),
  Region(
    id: 'tashkent-region',
    name: 'Tashkent Region',
  ),
  Region(
    id: 'fergana',
    name: 'Fergana',
  ),
  Region(
    id: 'andijan',
    name: 'Andijan',
  ),
  Region(
    id: 'namangan',
    name: 'Namangan',
  ),
  Region(
    id: 'kashkadarya',
    name: 'Kashkadarya',
  ),
  Region(
    id: 'navoi',
    name: 'Navoi',
  ),
  Region(
    id: 'jizzakh',
    name: 'Jizzakh',
  ),
  Region(
    id: 'sirdaryo',
    name: 'Sirdaryo',
  ),
  Region(
    id: 'surxondaryo',
    name: 'Surxondaryo',
  ),
];
