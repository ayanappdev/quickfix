import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickfix/Screens/Orders%20Screen/Components/order_detail_sheet.dart';

class OrderCardWidget extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String customerContact;
  final String vehicleDetails;
  final String serviceRequested;
  final Timestamp orderDate;
  final String location;
  final  estimatedCost;
  final double latitude;
  final double longitude;

  const OrderCardWidget({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.customerContact,
    required this.vehicleDetails,
    required this.serviceRequested,
    required this.orderDate,
    required this.location,
    required this.estimatedCost,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showOrderDetails(context),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 10),
              _buildInfoRow(Icons.person, 'Mechanic ', customerName),
              _buildInfoRow(Icons.phone, 'Contact', customerContact),
              const Divider(),
                         _buildInfoRow(Icons.attach_money, 'Cost', '\PKR ${estimatedCost}'),
      
              _buildInfoRow(Icons.build, 'Service', serviceRequested),
              const Divider(),
              _buildInfoRow(Icons.event, 'Date', orderDate.toString()), 
              _buildInfoRow(Icons.location_on, 'Location', location),
   
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Order ID: $orderId', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 27, 111, 97), fontSize: 16)),
        Icon(Icons.more_vert, color: Color.fromARGB(255, 27, 111, 97)),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Color.fromARGB(255, 27, 111, 97)),
          const SizedBox(width: 10),
          Expanded(child: Text('$label: $text', style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OrderDetailsSheet(
          customerName: customerName,
          vehicleDetails: vehicleDetails,
          serviceRequested: serviceRequested,
          orderDate: orderDate.toString(),
          location: location,
          shopLat: latitude, shopLng: longitude,
        );
      },
    );
  }
}




