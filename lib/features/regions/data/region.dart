class Region {
  final String id;   // e.g. 'samarkand'
  final String name; // e.g. 'Samarkand'
  final String? image; // optional hero image path/URL

  const Region({required this.id, required this.name, this.image});
}

const regions = <Region>[
  Region(id: 'samarkand', name: 'Samarkand'),
  Region(id: 'bukhara', name: 'Bukhara'),
  Region(id: 'karakalpakstan', name: 'Karakalpakstan'),
];
