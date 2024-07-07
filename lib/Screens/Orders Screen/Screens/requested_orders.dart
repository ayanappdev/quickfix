import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickfix/Screens/Orders%20Screen/Components/order_card_widget.dart';

class RequestedOrderScreen extends StatelessWidget {
  const RequestedOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid; 
    return Scaffold(
    
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requestedorders')
            .doc(userId) 
            .collection('orders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          var orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];
              return OrderCardWidget(
  orderId: order["userId"] ?? "",
  customerName: order['workerName'] ?? "",
  customerContact: order["workerName"] ?? "",
  vehicleDetails: 'Toyota Corolla 2020',
  serviceRequested: order["selectedServices"][0]["title"],

  orderDate: order["date"] ?? "",
  location: order["shopAddress"] ?? "",
  estimatedCost: order["totalPrice"] ?? "",
 latitude: order["shopLat"] ?? "", longitude: order["shopLng"] ?? "",
);
            },
          );
        },
      ),
    );
  }
}
