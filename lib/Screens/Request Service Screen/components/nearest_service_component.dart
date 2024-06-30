import 'package:flutter/material.dart';


class NearestServiceComponent extends StatelessWidget {
  final String shopName;
  final String shopAddress;
  final String openHours;
  final String closingHours;
  final String duration;
  final String distance; // Distance in kilometers


  const NearestServiceComponent({
    Key? key,
    required this.shopName,
    required this.shopAddress,
    required this.openHours,
    required this.closingHours,
    required this.duration,
    required this.distance,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      shopName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 151, 86),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                 
                ],
              ),
              const SizedBox(height: 5),
              Text(
                shopAddress,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Open: $openHours',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 151, 86)),
                  ),
                  Text(
                    'Close: $closingHours',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 151, 86)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconInfo(Icons.access_time, 'Duration', duration),
                  _buildIconInfo(Icons.location_on, 'Distance', distance),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconInfo(IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color:const Color.fromARGB(255, 0, 151, 86), size: 20),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 151, 86),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 151, 86),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }}