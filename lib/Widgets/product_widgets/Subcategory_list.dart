import 'package:flutter/material.dart';
import 'package:quickfix/models/product.dart';

//final//
class SubcategoryList extends StatelessWidget {
  final List<Subcategory> subcategories;

  const SubcategoryList({Key? key, required this.subcategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var subcategory in subcategories)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(
                    8), // Adjusted radius to make it smaller
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(
                  subcategory.title,
                  style: TextStyle(
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
                        border:
                            Border.all(color: Color.fromARGB(255, 0, 151, 86)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove, color: Colors.black),
                        onPressed: () {
                          // Handle removing the service
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Color.fromARGB(255, 0, 158, 92)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.black),
                        onPressed: () {
                          // Handle adding the service
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle requesting a service
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Button color
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Request a Service",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:quickfix/models/product.dart';

// class SubcategoryList extends StatelessWidget {
//   final List<Subcategory> subcategories;

//   const SubcategoryList({super.key, required this.subcategories});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (var subcategory in subcategories)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   subcategory.title,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add, color: Colors.green),
//                   onPressed: () {
//                     // Handle adding the service
//                   },
//                 ),
//               ],
//             ),
//           ),
//         SizedBox(height: 20),
//         Center(
//           child: ElevatedButton(
//             onPressed: () {
//               // Handle requesting a service
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green, // Button color
//             ),
//             child: Text("Request a Service"),
//           ),
//         ),
//       ],
//     );
//   }
// }
