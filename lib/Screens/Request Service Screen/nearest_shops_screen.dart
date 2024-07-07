import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:quickfix/Screens/Home_Screen/home_screen.dart';
import 'package:quickfix/models/product.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:quickfix/Screens/Request%20Service%20Screen/components/nearest_service_component.dart';

import 'map_screen.dart';

class NearestShopsScreen extends StatefulWidget {
    final List<Subcategory> selectedServices;
  final double totalPrice;
  const NearestShopsScreen({Key? key, required this.selectedServices, required this.totalPrice}) : super(key: key);

  @override
  State<NearestShopsScreen> createState() => _NearestShopsScreenState();
}

class _NearestShopsScreenState extends State<NearestShopsScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final LocationPreferences _locationPrefs = LocationPreferences();

  double? userLat;
  double? userLng;

  Map<String, RouteData> routesData = {};

  @override
  void initState() {
    super.initState();
    _useSavedLocation();
 
  }

  void _useSavedLocation() async {
    try {
      Map<String, double?> location = await _locationPrefs.getLocation();
      userLat = location['latitude'];
      userLng = location['longitude'];

      if (userLat != null && userLng != null) {
        print('Saved position:-------->>>>>>>>>.. $userLat, $userLng');
        _fetchRoutes();
      } else {
        print('No saved location found.');
      }
    } catch (e) {
      print('Error fetching saved location: $e');
    }
  }

  Future<void> _fetchRoutes() async {
    String adminId = 'admin123';
    CollectionReference shopsRef = _db.collection('admin').doc(adminId).collection('shops');

    try {
      QuerySnapshot snapshot = await shopsRef.get();

      for (var doc in snapshot.docs) {
        var shop = doc.data() as Map<String, dynamic>;

        double shopLat = (shop['shopLat'] ?? 0).toDouble();
        double shopLng = (shop['shopLang'] ?? 0).toDouble();

        if (shopLat != 0 && shopLng != 0) {
          RouteData routeData = await _getRoute(userLat!, userLng!, shopLat, shopLng);
          routesData[doc.id] = routeData;
        }
      }

      setState(() {});
    } catch (e) {
      print('Error fetching routes: $e');
    }
  }

  Future<RouteData> _getRoute(double userLat, double userLng, double shopLat, double shopLng) async {
    try {
      String apiKey = '5b3ce3597851110001cf6248cf73a36d900f4107b41b9fba475237fa'; // Replace with your API key
      String url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=$userLng,$userLat&end=$shopLng,$shopLat';

      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('features') && data['features'].isNotEmpty) {
          var segments = data['features'][0]['properties']['segments'];
          if (segments != null && segments.isNotEmpty) {
            var segment = segments[0];

            int durationInSeconds = segment['duration'].round();
            double distanceInMeters = (segment['distance'] as num).toDouble();

            print('Duration: $durationInSeconds seconds');
            print('Distance: $distanceInMeters meters');

            return RouteData(durationInSeconds, distanceInMeters);
          } else {
            print('No segments data found');
          }
        } else {
          print('No routes data found');
        }
      } else {
        print('Failed to fetch route data: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Handle specific error cases based on status code
        if (response.statusCode == 404) {
          print('No routable point found near specified coordinates.');
          // Inform user or retry logic
        }
      }
    } catch (e) {
      print('Error fetching route data: $e');
      // Handle general error case
    }
    return RouteData(0, 0);
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

    String formatDistance( meters) {
      double kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(2)} km';
    }


  @override
  Widget build(BuildContext context) {
    String adminId = 'admin123';
    CollectionReference shopsRef = _db.collection('admin').doc(adminId).collection('shops');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Shops'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: shopsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting || userLat == null || userLng == null) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Skeletonizer(
                    child: NearestServiceComponent(
                      shopName: "Loading...",
                      shopAddress: "Loading...",
                 
                      duration: "Loading...",
                      distance: "Loading...", services: "Loading...",
                
                    ),
                  ),
                );
              },
            );
          }

          final data = snapshot.requireData;

          if (data.size == 0) {
            return const Center(
              child: Text('No shops available'),
            );
          }

          

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var shop = data.docs[index].data() as Map<String, dynamic>;
              var routeData = routesData[data.docs[index].id] ?? RouteData(0, 0);
               double shopLat = (shop['shopLat'] ?? 0).toDouble();
              double shopLng = (shop['shopLang'] ?? 0).toDouble();

              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  GoggleMapScreen(
                    userLat:userLat ,
                    userLng: userLng,
                    shopLat:shopLat  ,
                    shopLng:shopLng ,
                    shopName: shop['shopName'],
                    workerName: shop['workerName'],
                    phoneNumber: shop['phone'],
                    mechanicAddress: shop['address'],
                    selectedServices: widget.selectedServices,
                    totalPrice: widget.totalPrice,
                    
                  )));
                },
                child: NearestServiceComponent(
                  shopName: shop['shopName'] ?? 'Unknown',
                  shopAddress: shop['address'] ?? 'Unknown',
              
                  duration: formatDuration(routeData.durationInSeconds),
                  distance: formatDistance(routeData.distanceInMeters),
                  services: shop['services'] ?? "Unknown",
               
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class RouteData {
  final int durationInSeconds;
  final double distanceInMeters;

  RouteData(this.durationInSeconds, this.distanceInMeters);
}
