import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickfix/Screens/Request%20Service%20Screen/components/map_bottom_sheet.dart';
import 'package:quickfix/models/product.dart';

class GoggleMapScreen extends StatefulWidget {
  final double? userLat;
  final double? userLng;
  final double? shopLat;
  final double? shopLng;
  final String? phoneNumber;
  final String? mechanicAddress;
  final String? workerName;
  final String? shopName;
  final List<Subcategory>? selectedServices;
  final double? totalPrice;

  const GoggleMapScreen({
    super.key,
    this.userLat,
    this.userLng,
    this.shopLat,
    this.shopLng,
    this.phoneNumber,
    this.mechanicAddress,
    this.workerName,
    this.shopName,
    this.selectedServices,
    this.totalPrice,
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

  Future<void> _storeData() async {
    showLoadingDialog(context); // Show loading dialog

    CollectionReference routes = FirebaseFirestore.instance.collection('requestedorders');

    await routes.add({
      'userLat': widget.userLat,
      'userLng': widget.userLng,
      'shopLat': widget.shopLat,
      'shopLng': widget.shopLng,
      'phoneNumber': widget.phoneNumber,
      'mechanicAddress': widget.mechanicAddress,
      'workerName': widget.workerName,
      'shopName': widget.shopName,
      'selectedServices': widget.selectedServices?.map((service) => service.toMap()).toList(),
      'totalPrice': widget.totalPrice,
      'distance': distanceInMeters,
      'duration': durationInSeconds,
    }).then((value) {
      Navigator.of(context).pop(); // Close loading dialog
      showSuccessDialog(context); // Show success dialog
      print("Data added successfully");
    }).catchError((error) {
      Navigator.of(context).pop(); // Close loading dialog
      print("Failed to add data: $error");
    });
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Please wait..."),
            ],
          ),
        );
      },
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Your request has been placed successfully!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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
                    LatLng(widget.userLat ?? _center.latitude,
                        widget.userLng ?? _center.longitude),
                  ),
                );
              },
              backgroundColor: const Color.fromARGB(255, 45, 131, 95),
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: MapBottomSheet(
        distance: '${formatDistance(distanceInMeters)}',
        duration: "ETA: ${formatDuration(durationInSeconds)}",
        shopName: widget.shopName!,
        mechanicName: widget.workerName!,
        address: widget.mechanicAddress!,
        phoneNumber: widget.phoneNumber!,
        onPressed: () {
          _storeData();
        },
      ),
    );
  }
}
