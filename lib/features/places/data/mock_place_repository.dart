import 'dart:async';
import 'place.dart';
import 'place_repository.dart';

class MockPlaceRepository implements PlaceRepository {
  final _data = <Place>[
    const Place(
      id: '1',
      name: 'Registan',
      city: 'Samarkand',
      country: 'Uzbekistan',
      description: 'Historic square framed by three madrasahs with stunning mosaics.',
      rating: 4.9,
      imageUrl: 'https://images.unsplash.com/photo-1582623690729-6c8f1e803c05?q=80&w=1200&auto=format&fit=crop',
      lat: 39.6542, lng: 66.9750,
    ),
    const Place(
      id: '2',
      name: 'Itchan Kala',
      city: 'Khiva',
      country: 'Uzbekistan',
      description: 'Walled inner town with minarets and narrow lanes—UNESCO site.',
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1606761568499-6b2fe8a3c6f5?q=80&w=1200&auto=format&fit=crop',
      lat: 41.3790, lng: 60.3609,
    ),
    const Place(
      id: '3',
      name: 'Ark Fortress',
      city: 'Bukhara',
      country: 'Uzbekistan',
      description: 'Ancient fortress, residence of emirs, with museum exhibits.',
      rating: 4.7,
      imageUrl: 'https://images.unsplash.com/photo-1595436252086-796adb0f34a1?q=80&w=1200&auto=format&fit=crop',
      lat: 39.7772, lng: 64.4158,
    ),
  ];

  @override
  Future<List<Place>> getPopularPlaces() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _data;
  }

  @override
  Future<Place?> getPlaceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _data.firstWhere((p) => p.id == id, orElse: () => _data.first);
  }
}
