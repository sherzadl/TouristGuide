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
    image: 'assets/regions/khorezm_cover.jpg',
  ),
  Region(
    id: 'tashkent-city',
    name: 'Tashkent City',
    image: 'assets/regions/tashkent_cover.jpg',
  ),
  Region(
    id: 'tashkent-region',
    name: 'Tashkent Region',
    image: 'assets/regions/tashkentregion_cover.jpg',
  ),
  Region(
    id: 'fergana',
    name: 'Fergana',
    image: 'assets/regions/fergana_cover.jpg',
  ),
  Region(
    id: 'andijan',
    name: 'Andijan',
    image: 'assets/regions/andijan_cover.jpg',
  ),
  Region(
    id: 'namangan',
    name: 'Namangan',
    image: 'assets/regions/namangan_cover.jpg',
  ),
  Region(
    id: 'kashkadarya',
    name: 'Kashkadarya',
    image: 'assets/regions/kashkadaryda_cover.jpg',
  ),
  Region(
    id: 'navoi',
    name: 'Navoi',
    image: 'assets/regions/navoi_cover.jpg',
  ),
  Region(
    id: 'jizzakh',
    name: 'Jizzakh',
    image: 'assets/regions/jizzakh_cover.jpg',
  ),
  Region(
    id: 'sirdaryo',
    name: 'Sirdaryo',
    image: 'assets/regions/sirdaryo_cover.jpg',
  ),
  Region(
    id: 'surxondaryo',
    name: 'Surxondaryo',
    image: 'assets/regions/surxondaryo_cover.jpg',
  ),
];
