import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../places/data/place_repository.dart';
import '../../../shared/providers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  static const CameraPosition _uzbekistan = CameraPosition(
    target: LatLng(41.3775, 64.5853), // roughly center of Uzbekistan
    zoom: 5.8,
  );

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final repo = ref.read(placeRepositoryProvider);
    final places = await repo.getPopularPlaces();
    final markers = places.where((p) => p.lat != null && p.lng != null).map((p) {
      return Marker(
        markerId: MarkerId(p.id),
        position: LatLng(p.lat!, p.lng!),
        infoWindow: InfoWindow(title: p.name, snippet: '${p.city}, ${p.country}'),
      );
    }).toSet();

    if (mounted) {
      setState(() {
        _markers
          ..clear()
          ..addAll(markers);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: GoogleMap(
        initialCameraPosition: _uzbekistan,
        markers: _markers,
        onMapCreated: (c) => _controller.complete(c),
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
