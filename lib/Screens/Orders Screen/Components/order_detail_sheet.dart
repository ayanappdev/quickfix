import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:quickfix/Screens/Home_Screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickfix/Screens/Request%20Service%20Screen/map_screen.dart';

class OrderDetailsSheet extends StatefulWidget {
  final String customerName;
  final String vehicleDetails;
  final String serviceRequested;
  final String orderDate;
  final String location;
  final double shopLat;
  final double shopLng;

  const OrderDetailsSheet({
    Key? key,
    required this.customerName,
    required this.vehicleDetails,
    required this.serviceRequested,
    required this.orderDate,
    required this.location,
    required this.shopLat,
    required this.shopLng,
  }) : super(key: key);

  @override
  State<OrderDetailsSheet> createState() => _OrderDetailsSheetState();
}

class _OrderDetailsSheetState extends State<OrderDetailsSheet> {
  double? userLat;
  double? userLng;
  late GoogleMapController _mapController;
  Set<Polyline> _polylines = {};
  int durationInSeconds = 0;
  double distanceInMeters = 0.0;
    final LocationPreferences _locationPrefs = LocationPreferences();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

   void _getUserLocation() async {
    try {
      Map<String, double?> location = await _locationPrefs.getLocation();
      userLat = location['latitude'];
      userLng = location['longitude'];

      if (userLat != null && userLng != null) {
        print('Saved position:-------->>>>>>>>>.. $userLat, $userLng');
        _getRoute();
      } else {
        print('No saved location found.');
      }
    } catch (e) {
      print('Error fetching saved location: $e');
    }
  }

  Future<void> _getRoute() async {
    if (userLat == null || userLng == null) return;

    String apiKey = '5b3ce3597851110001cf6248cf73a36d900f4107b41b9fba475237fa'; // Replace with your OpenRouteService API key
    String url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$userLng,$userLat&end=${widget.shopLng},${widget.shopLat}';
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

  List<LatLng> _extractPolyline(Map<String, dynamic> data) {
    List<LatLng> polylinePoints = [];

    var coordinates = data['features'][0]['geometry']['coordinates'];
    for (var coordinate in coordinates) {
      polylinePoints.add(LatLng(coordinate[1], coordinate[0]));
    }

    return polylinePoints;
  }

  void _addPolyline(List<LatLng> polylinePoints) {
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 1.0,
      maxChildSize: 1.0,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 27, 111, 97),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoTile(Icons.person, 'Customer', widget.customerName),
                  _buildDivider(),
                  _buildInfoTile(Icons.directions_car, 'Vehicle', widget.vehicleDetails),
                  _buildDivider(),
                  _buildInfoTile(Icons.build, 'Service', widget.serviceRequested),
                  _buildDivider(),
                  _buildInfoTile(Icons.event, 'Date', widget.orderDate),
                  _buildDivider(),
                  _buildInfoTile(Icons.location_on, 'Location', widget.location),
                  const SizedBox(height: 20),
                  
                 
                  const SizedBox(height: 20),
                  SizedBox(
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      _navigateToMapScreen(context);
      print(userLat);
      print(userLng);
      print(widget.shopLat);
      print(widget.shopLng);
    },
    icon: Icon(Icons.navigation, color: Colors.white),
    label: Text('Show In Map'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 27, 111, 97),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 15),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToMapScreen(BuildContext context) {
    if (userLat != null && userLng != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoggleMapScreen(
            userLat: userLat!,
            userLng: userLng!,
            shopLat: widget.shopLat,
            shopLng: widget.shopLng,
            shopName: 'Shop Name', // Replace with actual shop name
            mechanicAddress: 'Mechanic Address', // Replace with actual address
            workerName: 'Worker Name', // Replace with actual worker name
            phoneNumber: '1234567890', // Replace with actual phone number
            selectedServices: [], // Replace with actual selected services if needed
            totalPrice: 0.0, // Replace with actual total price
          ),
        ),
      );
    }
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 27, 111, 97)),
      title: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[700]),
      ),
      subtitle: Text(
        value,
        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      indent: 15,
      endIndent: 15,
    );
  }
}
