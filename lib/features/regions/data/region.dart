class Region {
  final String id;     // e.g. 'samarkand'
  final String name;   // e.g. 'Samarkand'
  final String? image; // e.g. 'assets/regions/samarkand_cover.jpg'

  const Region({
    required this.id,
    required this.name,
    this.image,
  });
}

const regions = <Region>[
  Region(
    id: 'samarkand',
    name: 'Samarkand',
    image: 'assets/regions/samarkand_cover.jpg',
  ),
  Region(
    id: 'bukhara',
    name: 'Bukhara',
    image: 'assets/regions/bukhara_cover.jpg',
  ),
  Region(
    id: 'karakalpakstan',
    name: 'Karakalpakstan',
    image: 'assets/regions/karakalpakstan_cover.jpg',
  ),

  // you can add more regions:
  // Region(id: 'tashkent', name: 'Tashkent', image: 'assets/regions/tashkent_cover.jpg'),
  // Region(id: 'khorezm', name: 'Khorezm', image: 'assets/regions/khorezm_cover.jpg'),
];
