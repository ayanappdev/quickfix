import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickfix/Screens/Orders%20Screen/Components/order_card_widget.dart';
import 'package:quickfix/Screens/Request%20Service%20Screen/components/nearest_service_component.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UnderProcessingOrderScreen extends StatelessWidget {
  const UnderProcessingOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final user = FirebaseAuth.instance.currentUser;
      String userId = user!.uid; 
    return Scaffold(
    
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('acceptedorders')
            .doc(userId) 
            .collection('acceptedordersvalues')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Skeletonizer(
                    child: NearestServiceComponent(
                      shopName: "Loading...",
                      shopAddress: "Loading...",
                                         duration: "Loading...",
                      distance: "Loading...",
                      services: "loading....",
                
                    ),
                  ),
                );
              },
            );
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
