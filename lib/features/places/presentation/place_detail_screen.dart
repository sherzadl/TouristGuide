// lib/features/places/presentation/place_detail_screen.dart
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/place.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String placeId;
  final Place? initialPlace;
  const PlaceDetailScreen({
    super.key,
    required this.placeId,
    this.initialPlace,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  final Completer<GoogleMapController> _mapController =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final place = widget.initialPlace; // we’re using the passed-in Place

    return Scaffold(
      appBar: AppBar(title: Text(place?.name ?? 'Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: place?.imageUrl ?? '',
              fit: BoxFit.cover,
              placeholder: (_, __) => const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: Colors.black12,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),

          if (place != null) ...[
            Text(
              place.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 18),
                const SizedBox(width: 6),
                Text('${place.city}, ${place.country}'),
                const Spacer(),
                const Icon(Icons.star, size: 18),
                const SizedBox(width: 4),
                Text(place.rating.toStringAsFixed(1)),
              ],
            ),
            const SizedBox(height: 12),
            Text(place.description),
            const SizedBox(height: 24),

            Text(
              'Location',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // Embedded map for this place
            if (place.lat != null && place.lng != null)
              SizedBox(
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(place.lat!, place.lng!),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId(place.id),
                        position: LatLng(place.lat!, place.lng!),
                        infoWindow: InfoWindow(title: place.name),
                      ),
                    },
                    onMapCreated: (c) => _mapController.complete(c),
                    mapToolbarEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
              )
            else
              const Text('Map location coming soon.'),

            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () async {
                if (place.lat == null || place.lng == null) return;
                final uri = Uri.parse(
                  'https://www.google.com/maps/search/?api=1&query=${place.lat},${place.lng}',
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('Open in Google Maps'),
            ),
          ],
        ],
      ),
    );
  }
}
