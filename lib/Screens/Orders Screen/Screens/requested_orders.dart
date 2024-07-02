import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
