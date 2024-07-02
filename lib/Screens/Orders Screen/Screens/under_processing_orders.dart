import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                return  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Skeletonizer(
                    child: NearestServiceComponent(
                      shopName: "Loading...",
                      shopAddress: "Loading...",
                      openHours: "Loading...",
                      closingHours: "Loading...",
                      duration: "Loading...",
                      distance: "Loading...",
                
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
              return ListTile(
                title: Text(order['totalPrice'].toString()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 
                    Text('Price: ${order['totalPrice']}'),
                    Text('Total Price: ${order['totalPrice']}'),
                    Text('Timestamp: ${order['timestamp']}'),
                    Text('User ID: ${order['userId']}'),
                    Text('User Name: ${order['userName']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
