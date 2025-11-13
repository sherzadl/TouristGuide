import 'place.dart';

/// This is your "database" of all places.
final List<Place> allPlaces = [
  Place(
    id: 'registan',
    name: 'Registan Square',
    city: 'Samarkand',
    country: 'Uzbekistan',
    regionId: 'samarkand',
    description:
    'Registan is the historic heart of Samarkand, framed by three majestic madrasahs... '
        'You can write 2–3 paragraphs here about history, architecture, and why it is special.',
    rating: 4.9,
    imageUrl: 'assets/places/samarkand/registan_1.jpg',
    lat: 39.6542,
    lng: 66.9750,
    visitingHours: 'Daily, 09:00 – 18:00',
    ticketInfo: 'Approx. 50,000 UZS for adults, discounts for students.',
    bestSeason: 'Spring and Autumn',
    tips: 'Best light is around sunset. Dress modestly; respect local customs.',
  ),

  // Add more places here:
  // - Gur-Emir Mausoleum (Samarkand)
  // - Ark Fortress (Bukhara)
  // - Kalon Minaret
  // - Itchan Kala (Khiva / Karakalpakstan area)
  // etc.
];
