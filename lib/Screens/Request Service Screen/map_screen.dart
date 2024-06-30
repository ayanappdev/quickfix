import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoggleMapScreen extends StatefulWidget {
  final double? userLat;
  final double? userLng;
  final double? shopLat;
  final double? shopLng;
  final String? phoneNumber;
  final String? mechanicAddress;
  final String? workerName;
  final String? shopName;

  const GoggleMapScreen({
    super.key,
    this.userLat,
    this.userLng,
    this.shopLat,
    this.shopLng, this.phoneNumber, this.mechanicAddress, this.workerName, this.shopName,
  });

  @override
  State<GoggleMapScreen> createState() => _GoggleMapScreenState();
}

class _GoggleMapScreenState extends State<GoggleMapScreen> {
  late GoogleMapController mapController;
  final Set<Polyline> _polylines = Set<Polyline>();
  final Set<Marker> _markers = {};
  final LatLng _center = const LatLng(24.8607, 67.0011);

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
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248cf73a36d900f4107b41b9fba475237fa&start=${widget.userLng},${widget.userLat}&end=${widget.shopLng},${widget.shopLat}';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('features') && data['features'].isNotEmpty) {
        var segments = data['features'][0]['properties']['segments'];
        if (segments != null && segments.isNotEmpty) {
          var segment = segments[0];

          setState(() {
            durationInSeconds = segment['duration'].round();
            distanceInMeters = segment['distance'];
          });

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
        print('No routes data found');
      }
    } else {
      print('Failed to fetch route data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void _addPolyline(List<LatLng> polylinePoints) {
    setState(() {
      _polylines.clear();
      _markers.clear();

      _polylines.add(Polyline(
        polylineId: const PolylineId('route1'),
        visible: true,
        points: polylinePoints,
        color: const Color.fromARGB(255, 0, 151, 86),
        width: 5,
      ));

      _markers.add(Marker(
        markerId: const MarkerId('start'),
        position: polylinePoints.first,
        infoWindow: const InfoWindow(title: 'Start'),
      ));

      _markers.add(Marker(
        markerId: const MarkerId('end'),
        position: polylinePoints.last,
        infoWindow: const InfoWindow(title: 'End'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueBlue,
        ),
      ));
    });
  }

  List<LatLng> _extractPolyline(Map<String, dynamic> data) {
    if (data.containsKey('features') && data['features'].isNotEmpty) {
      List<dynamic> coordinates = data['features'][0]['geometry']['coordinates'];
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
        backgroundColor: const Color.fromARGB(255, 45, 131, 95),
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
        right: 20,
        child: FloatingActionButton(
          onPressed: () {
            mapController.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(widget.userLat ?? _center.latitude, widget.userLng ?? _center.longitude),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 45, 131, 95),
          child: const Icon(Icons.my_location,color: Colors.white,),
        ),
      ),
          
        ],
      ),
     
      bottomSheet: _buildBottomSheet(),
    );
  }

Widget _buildBottomSheet() {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, -2),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0), // Adjust top padding
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.timer, color: Color.fromARGB(255, 45, 131, 95), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'ETA: ${formatDuration(durationInSeconds)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.directions, color: Color.fromARGB(255, 45, 131, 95), size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '${formatDistance(distanceInMeters)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey[400]), // Add a divider for separation
        
        // Shop Name
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.store, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Shop Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        
        // Mechanic Name
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.person, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mechanic Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        
        // Location
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '123 Main Street, City Name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        
        // Phone Number
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.phone, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Text(
                '+1234567890',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        
        // Request Button
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 45, 131, 95),
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Request Service',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        
        // Add more custom information as needed
        
      ],
    ),
  );
}


}
