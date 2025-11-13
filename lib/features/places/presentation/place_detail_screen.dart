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
    final place = widget.initialPlace;

    return Scaffold(
      appBar: AppBar(
        title: Text(place?.name ?? 'Details'),
      ),
      body: place == null
          ? const Center(child: Text('Place details not available.'))
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _buildImage(place),
          ),
          const SizedBox(height: 16),
          Text(
            place.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${place.city}, ${place.country}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.star, size: 18),
              const SizedBox(width: 4),
              Text(place.rating.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            place.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          if (place.visitingHours != null ||
              place.ticketInfo != null ||
              place.bestSeason != null)
            _buildInfoChips(place),
          if (place.tips != null) ...[
            const SizedBox(height: 16),
            Text(
              'Travel tip',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(place.tips!),
          ],
          const SizedBox(height: 24),
          Text(
            'Location',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (place.latitude != null && place.longitude != null)
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(place.latitude!, place.longitude!),
                    zoom: 13.5,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(place.id),
                      position:
                      LatLng(place.latitude!, place.longitude!),
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
              if (place.latitude == null || place.longitude == null) {
                return;
              }
              final uri = Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}',
              );
              if (await canLaunchUrl(uri)) {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            icon: const Icon(Icons.map_outlined),
            label: const Text('Open in Google Maps'),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Place place) {
    if (place.imageUrl.startsWith('assets/')) {
      return Image.asset(place.imageUrl, fit: BoxFit.cover);
    }
    return CachedNetworkImage(
      imageUrl: place.imageUrl,
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
    );
  }

  Widget _buildInfoChips(Place place) {
    final chips = <Widget>[];

    if (place.visitingHours != null) {
      chips.add(_InfoChip(
        icon: Icons.schedule_outlined,
        label: place.visitingHours!,
      ));
    }
    if (place.ticketInfo != null) {
      chips.add(_InfoChip(
        icon: Icons.confirmation_num_outlined,
        label: place.ticketInfo!,
      ));
    }
    if (place.bestSeason != null) {
      chips.add(_InfoChip(
        icon: Icons.wb_sunny_outlined,
        label: 'Best season: ${place.bestSeason!}',
      ));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: chips,
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
