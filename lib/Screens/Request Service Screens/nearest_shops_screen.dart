import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearestShopsScreen extends StatefulWidget {
  const NearestShopsScreen({super.key});

  @override
  State<NearestShopsScreen> createState() => _NearestShopsScreenState();
}

class _NearestShopsScreenState extends State<NearestShopsScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
              return ListTile(
                title: Text(shop['shopName']),
                subtitle: Text(shop['address']),
                onTap: () {
            
                },
              );
            },
          );
        },
      ),
    );
  }
}
