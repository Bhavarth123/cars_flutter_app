import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GarageLocationScreen extends StatefulWidget {
  const GarageLocationScreen({super.key});

  @override
  State<GarageLocationScreen> createState() => _GarageLocationScreenState();
}

class _GarageLocationScreenState extends State<GarageLocationScreen> {
  // Jay Chamunda Motors coordinates
  final LatLng garageLocation = const LatLng(22.2686216, 70.8006619);

  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // Center camera on your shop location
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(garageLocation, 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jay Chamunda Motors"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: garageLocation,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('garage'),
            position: garageLocation,
            infoWindow: const InfoWindow(title: "Jay Chamunda Motors"),
          ),
        },
        myLocationEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
