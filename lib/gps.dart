import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  final double lat;
  final double lon;

  const GoogleMapPage({
    Key? key,
    required this.lat,
    required this.lon,
  }) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    final LatLng location = LatLng(widget.lat, widget.lon);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location on Map'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('sensorLocation'),
            position: location,
            infoWindow: const InfoWindow(title: 'Sensor Location'),
          ),
        },
        onMapCreated: (controller) => mapController = controller,
      ),
    );
  }
}
