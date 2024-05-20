import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quickfix/Screens/product_screen.dart';
import 'package:quickfix/constants.dart';
import 'package:quickfix/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kcontentColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.white, kcontentColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            product.imagePaths[1],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                product.colors.length,
                                (cindex) => Container(
                                  height: 15,
                                  width: 15,
                                  margin: const EdgeInsets.only(right: 2),
                                  decoration: BoxDecoration(
                                    color: product.colors[cindex],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 38, 119, 78),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: const Icon(
                  Ionicons.heart_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}














































































































// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:quickfix/Screens/product_screen.dart';
// import 'package:quickfix/constants.dart';
// import 'package:quickfix/models/product.dart';
// // import 'package:shop_example/constants.dart';
// // import 'package:shop_example/models/product.dart';
// // import 'package:shop_example/screens/product_screen.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;
//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => ProductScreen(product: product),
//           ),
//         );
//       },
//       child: Stack(
//         children: [
//           Container(
//             height: 250,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: kcontentColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               children: [
//                 Image.asset(
//                   product.image,
//                   width: 120,
//                   height: 120,
//                 ),
//                 Text(
//                   product.title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       "\$${product.price}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Row(
//                       children: List.generate(
//                         product.colors.length,
//                         (cindex) => Container(
//                           height: 15,
//                           width: 15,
//                           margin: const EdgeInsets.only(right: 2),
//                           decoration: BoxDecoration(
//                             color: product.colors[cindex],
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                 width: 30,
//                 height: 30,
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 38, 119, 78),
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(20),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                 ),
//                 child: const Icon(
//                   Ionicons.heart_outline,
//                   color: Colors.white,
//                   size: 18,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
