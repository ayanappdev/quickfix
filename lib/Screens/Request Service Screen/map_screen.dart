import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:quickfix/Screens/Request%20Service%20Screen/components/map_bottom_sheet.dart';
import 'package:quickfix/models/product.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:ui' as ui;

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
  String _mapStyle = '';

  @override
  void initState() {
    super.initState();
    _getRoute();
    _loadMapStyle();
    _addCustomMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  Future<void> _addCustomMarkers() async {
    final Uint8List userIcon = await _getBytesFromAsset('assets/images/location.png', 100, Color.fromARGB(255, 0, 151, 86));
    final Uint8List shopIcon = await _getBytesFromAsset('assets/images/service.png', 70, Color.fromARGB(255, 0, 151, 86));

    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('start'),
        position: LatLng(widget.userLat ?? _center.latitude, widget.userLng ?? _center.longitude),
        infoWindow: InfoWindow(title: 'Start'),
        icon: BitmapDescriptor.fromBytes(userIcon),
      ));

      _markers.add(Marker(
        markerId: MarkerId('end'),
        position: LatLng(widget.shopLat ?? _center.latitude, widget.shopLng ?? _center.longitude),
        infoWindow: InfoWindow(title: 'End'),
        icon: BitmapDescriptor.fromBytes(shopIcon),
      ));
    });
  }

 Future<Uint8List> _getBytesFromAsset(String path, int width, Color color) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  ui.Image originalImage = fi.image;

  // Create a new picture recorder to draw the image with the color filter
  ui.PictureRecorder recorder = ui.PictureRecorder();
  Canvas canvas = Canvas(recorder);

  Paint paint = Paint()
    ..colorFilter = ui.ColorFilter.mode(color, BlendMode.srcIn);

  // Draw the original image onto the canvas with the color filter
  canvas.drawImage(originalImage, Offset.zero, paint);

  // End recording and convert the picture to an image
  ui.Image coloredImage = await recorder.endRecording().toImage(originalImage.width, originalImage.height);

  ByteData? coloredByteData = await coloredImage.toByteData(format: ui.ImageByteFormat.png);
  return coloredByteData!.buffer.asUint8List();
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
      _polylines.add(Polyline(
        polylineId: const PolylineId('route1'),
        visible: true,
        points: polylinePoints,
        color: const Color.fromARGB(255, 0, 151, 86),
        width: 5,
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

  Future<void> _storeData() async {
    showLoadingDialog(context);

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String? userName = user.displayName; 
      String userId = user.uid; 

      CollectionReference userOrders = FirebaseFirestore.instance
          .collection('requestedorders')
          .doc(userId) 
          .collection('orders'); 

      await userOrders.add({
        'userId': userId, 
        'userName': userName, 
        'selectedServices': widget.selectedServices?.map((service) => service.toMap()).toList(),
        'totalPrice': widget.totalPrice,
        'timestamp': FieldValue.serverTimestamp(), 
        'workerName': widget.workerName,
        'shopLat':widget.shopLat,
        'shopLng': widget.shopLng,
        'shopAddress':widget.mechanicAddress,
        'date': DateTime.now(),
        'workerPhone':widget.phoneNumber
      }).then((value) {
        Navigator.of(context).pop(); 
        showSuccessDialog(context); 
        print("Data added successfully");
      }).catchError((error) {
        Navigator.of(context).pop();
        print("Failed to add data: $error");
      });
    } else {
      Navigator.of(context).pop();
      print("User not authenticated");
    }
  }

  void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 45, 131, 95)),
              ),
              SizedBox(width: 20),
              Text(
                "Please wait...",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
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
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: EdgeInsets.all(20.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Color.fromARGB(255, 45, 131, 95),
              size: 60,
            ),
            SizedBox(height: 20),
            Text(
              "Success",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 45, 131, 95),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your request has been placed successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: TextStyle(
                color: Color.fromARGB(255, 45, 131, 95),
                fontSize: 18,
              ),
            ),
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
        distance: formatDistance(distanceInMeters),
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
