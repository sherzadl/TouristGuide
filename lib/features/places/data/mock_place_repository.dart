import 'place.dart';
import 'place_repository.dart';

class MockPlaceRepository implements PlaceRepository {
  final List<Place> _data = <Place>[
    const Place(
      id: '1',
      name: 'Registan',
      city: 'Samarkand',
      country: 'Uzbekistan',
      description: 'Historic square framed by three madrasahs with stunning mosaics.',
      rating: 4.9,
      imageUrl: 'https://picsum.photos/seed/registan/1200/800',
      lat: 39.6542, lng: 66.9750,
      regionId: 'samarkand',
    ),
    const Place(
      id: '2',
      name: 'Itchan Kala',
      city: 'Khiva',
      country: 'Uzbekistan',
      description: 'Walled inner town with minarets and narrow lanes—UNESCO site.',
      rating: 4.8,
      imageUrl: 'https://picsum.photos/seed/itchankala/1200/800',
      lat: 41.3790, lng: 60.3609,
      regionId: 'karakalpakstan',
    ),
    const Place(
      id: '3',
      name: 'Ark Fortress',
      city: 'Bukhara',
      country: 'Uzbekistan',
      description: 'Ancient fortress, residence of emirs, with museum exhibits.',
      rating: 4.7,
      imageUrl: 'https://picsum.photos/seed/ark/1200/800',
      lat: 39.7772, lng: 64.4158,
      regionId: 'bukhara',
    ),
  ];

  @override
  Future<List<Place>> getPopularPlaces() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _data;
  }

  @override
  Future<Place?> getPlaceById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    try {
      return _data.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Place>> getPlacesByRegion(String regionId) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _data.where((p) => p.regionId == regionId).toList();
  }
}
