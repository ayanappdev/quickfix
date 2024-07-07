import 'package:flutter/material.dart';

class NearestServiceComponent extends StatelessWidget {
  final String shopName;
  final String shopAddress;
  final String services; // String representing services provided by the shop
  final String duration;
  final String distance; // Distance in kilometers

  const NearestServiceComponent({
    Key? key,
    required this.shopName,
    required this.shopAddress,
    required this.services,
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
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 246, 248, 247),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.build, color: Color.fromARGB(255, 0, 151, 86), size: 16),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        services,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
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
        Icon(icon, color: Color.fromARGB(255, 0, 151, 86), size: 20),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style:  TextStyle(
                    color: Colors.black.withOpacity(0.6),
       
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style:  TextStyle(
                fontSize: 14,
                 color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
