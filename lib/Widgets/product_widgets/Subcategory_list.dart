import 'package:flutter/material.dart';
import 'package:quickfix/models/product.dart';
import '../../Screens/Request Service Screen/nearest_shops_screen.dart';

class SubcategoryList extends StatefulWidget {
  final List<Subcategory> subcategories;

  const SubcategoryList({Key? key, required this.subcategories}) : super(key: key);

  @override
  _SubcategoryListState createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  final List<Subcategory> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    double totalPrice = selectedServices.fold(0, (sum, service) => sum + service.price);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var subcategory in widget.subcategories)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8), // Adjusted radius to make it smaller
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(
                  subcategory.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color.fromARGB(255, 0, 151, 86)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.remove, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            selectedServices.remove(subcategory);
                            // Print the updated list to the debug console
                            print("Selected Services:");
                            selectedServices.forEach((service) {
                              print("${service.title}: ${service.price}");
                            });
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color.fromARGB(255, 0, 158, 92)),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            selectedServices.add(subcategory);
                            // Print the updated list to the debug console
                            print("Selected Services:");
                            selectedServices.forEach((service) {
                              print("${service.title}: ${service.price}");
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NearestShopsScreen(
                              selectedServices: selectedServices,
                              totalPrice: totalPrice,
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Request a Service",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 5),
            FloatingActionButton(
              onPressed: () {
         
              },
             
              child: Text(
                                totalPrice.toString(),
                // "Total Price: $totalPrice PKR (${selectedServices.length})",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
