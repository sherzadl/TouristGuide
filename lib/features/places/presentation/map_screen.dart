import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../shared/providers.dart';
import '../data/place_repository.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});
  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final Set<Marker> _markers = <Marker>{};

  static const _uzbekistan = CameraPosition(
    target: LatLng(41.3775, 64.5853),
    zoom: 5.8,
  );

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    final PlaceRepository repo = ref.read(placeRepositoryProvider);
    final places = await repo.getPopularPlaces();

    final markers = places
        .where((p) => p.lat != null && p.lng != null)
        .map((p) => Marker(
      markerId: MarkerId(p.id),
      position: LatLng(p.lat!, p.lng!),
      infoWindow: InfoWindow(
        title: p.name,
        snippet: '${p.city}, ${p.country}',
      ),
    ))
        .toSet();

    if (!mounted) return;
    setState(() {
      _markers
        ..clear()
        ..addAll(markers);
    });
  }

  Future<void> _recenterUzbekistan() async {
    final c = await _controller.future;
    await c.animateCamera(CameraUpdate.newCameraPosition(_uzbekistan));
  }

  Future<void> _zoomIn() async {
    final c = await _controller.future;
    await c.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> _zoomOut() async {
    final c = await _controller.future;
    await c.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _uzbekistan,
            markers: _markers,
            onMapCreated: (c) => _controller.complete(c),
            mapToolbarEnabled: true,
            zoomControlsEnabled: false, // we provide our own nice buttons
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
          ),

          // Floating zoom & recenter controls
          Positioned(
            right: 12,
            bottom: 16,
            child: Column(
              children: [
                _RoundButton(icon: Icons.add, onPressed: _zoomIn),
                const SizedBox(height: 10),
                _RoundButton(icon: Icons.remove, onPressed: _zoomOut),
                const SizedBox(height: 10),
                _RoundButton(icon: Icons.explore, onPressed: _recenterUzbekistan),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const _RoundButton({required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(icon, size: 22),
        ),
      ),
    );
  }
}
