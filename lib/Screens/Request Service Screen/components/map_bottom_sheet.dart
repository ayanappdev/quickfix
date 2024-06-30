import 'package:flutter/material.dart';

class MapBottomSheet extends StatelessWidget {
  final String distance;
  final String duration;
  final String shopName;
  final String mechanicName;
  final String address;
  final String phoneNumber;
  final VoidCallback onPressed;
  const MapBottomSheet({super.key, required this.distance, required this.duration, required this.shopName, required this.mechanicName, required this.address, required this.phoneNumber, required this.onPressed});

  @override
  Widget build(BuildContext context) {
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
                   duration,
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
                   distance,
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
         Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.store, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  shopName,
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
         Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.person, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                 mechanicName,
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
         Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                 address ,
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
         Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(Icons.phone, color: Color.fromARGB(255, 45, 131, 95), size: 24),
              SizedBox(width: 8),
              Text(
               phoneNumber ,
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
           onPressed();
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