import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster_plus/flutter_map_marker_cluster_plus.dart';
import 'package:latlong2/latlong.dart';

import 'drawer.dart';

class ClusteringManyMarkersPage extends StatefulWidget {
  static const String route = 'clusteringManyMarkersPage';

  const ClusteringManyMarkersPage({super.key});

  @override
  State<ClusteringManyMarkersPage> createState() => _ClusteringManyMarkersPageState();
}

class _ClusteringManyMarkersPageState extends State<ClusteringManyMarkersPage> {
  static const totalMarkers = 2000.0;
  final minLatLng = const LatLng(49.8566, 1.3522);
  final maxLatLng = const LatLng(58.3498, -10.2603);

  late List<Marker> markers;

  @override
  void initState() {
    final latitudeRange = maxLatLng.latitude - minLatLng.latitude;
    final longitudeRange = maxLatLng.longitude - minLatLng.longitude;

    final stepsInEachDirection = sqrt(totalMarkers).floor();
    final latStep = latitudeRange / stepsInEachDirection;
    final lonStep = longitudeRange / stepsInEachDirection;

    markers = [];
    for (var i = 0; i < stepsInEachDirection; i++) {
      for (var j = 0; j < stepsInEachDirection; j++) {
        final latLng = LatLng(
          minLatLng.latitude + i * latStep,
          minLatLng.longitude + j * lonStep,
        );

        markers.add(
          Marker(
            height: 30,
            width: 30,
            point: latLng,
            child: const Icon(Icons.pin_drop),
          ),
        );
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clustering Many Markers Page')),
      drawer: buildDrawer(context, ClusteringManyMarkersPage.route),
      body: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng((maxLatLng.latitude + minLatLng.latitude) / 2, (maxLatLng.longitude + minLatLng.longitude) / 2),
          initialZoom: 6,
          maxZoom: 15,
        ),
        children: <Widget>[
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(40, 40),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              maxZoom: 15,
              markers: markers,
              builder: (context, markers) {
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
