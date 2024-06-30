import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoggleMapScreen extends StatefulWidget {
  const GoggleMapScreen({super.key});

  @override
  State<GoggleMapScreen> createState() => _GoggleMapScreenState();
}

class _GoggleMapScreenState extends State<GoggleMapScreen> {
  late GoogleMapController mapController;
  final Set<Polyline> _polylines = Set<Polyline>();
  final Set<Marker> _markers = {};

  final LatLng _center = const LatLng(24.8607, 67.0011);
  final LatLng _destination = const LatLng(24.9211, 67.100); // Example destination

  int durationInSeconds = 0;
  double distanceInMeters = 0.0;

  @override
  void initState() {
    super.initState();
    _getRoute();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getRoute() async {
    String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248cf73a36d900f4107b41b9fba475237fa&start=${_center.longitude},${_center.latitude}&end=${_destination.longitude},${_destination.latitude}';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('features') && data['features'].isNotEmpty) {
        var segments = data['features'][0]['properties']['segments'];
        if (segments != null && segments.isNotEmpty) {
          var segment = segments[0];

          // Update the state with the real values
          setState(() {
            durationInSeconds = segment['duration'].round();
            distanceInMeters = segment['distance'];
          });
          print(durationInSeconds);
          List<LatLng> polylinePoints = _extractPolyline(data);
          if (polylinePoints.isNotEmpty) {
            _addPolyline(polylinePoints);
          } else {
            print('No route data found');
          }
        } else {
          print('No segments data found');
        }
      } else {
        print('API Response: ${response.statusCode}');
        print('No routes data found');
      }
    } else {
      // Handle the error
      print('Failed to fetch route data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void _addPolyline(List<LatLng> polylinePoints) {
    // Clear any existing polylines and markers to avoid duplicates
    setState(() {
      _polylines.clear();
      _markers.clear();

      _polylines.add(Polyline(
        polylineId: const PolylineId('route1'),
        visible: true,
        points: polylinePoints,
        color: Color.fromARGB(255, 0, 151, 86),
        width: 5,
      ));

      // Add start marker
      _markers.add(Marker(
        markerId: const MarkerId('start'),
        position: polylinePoints.first, // The first point of the polyline
        infoWindow: const InfoWindow(title: 'Start', snippet: ''),
      ));

      // Add end marker
      _markers.add(Marker(
        markerId: const MarkerId('end'),
        position: polylinePoints.last, // The last point of the polyline
        infoWindow: const InfoWindow(title: 'End', snippet: ''),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), // Change hue as needed
      ));
    });
  }

  List<LatLng> _extractPolyline(Map<String, dynamic> data) {
    // Extract and decode the polyline from the response
    if (data.containsKey('features') && data['features'].isNotEmpty) {
      List<dynamic> coordinates =
          data['features'][0]['geometry']['coordinates'];
      List<LatLng> polylinePoints = coordinates.map((coord) {
        double lat = coord[1].toDouble();
        double lng = coord[0].toDouble();
        return LatLng(lat, lng);
      }).toList();
      return polylinePoints;
    } else {
      return [];
    }
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    String formattedDuration = '';
    if (hours > 0) {
      formattedDuration += '${hours}h ';
    }
    if (minutes > 0 || hours > 0) {
      formattedDuration += '${minutes}m';
    }
    return formattedDuration;
  }

  String formatDistance(double meters) {
    double kilometers = meters / 1000;
    return '${kilometers.toStringAsFixed(2)} km';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Fix'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            polylines: _polylines,
            markers: _markers,
          ),

          Positioned(
            top: 20,
            left: 20,
            child: Card(
              elevation: 20,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Duration: ${formatDuration(durationInSeconds)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Distance: ${formatDistance(distanceInMeters)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
