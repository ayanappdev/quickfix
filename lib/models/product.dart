import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final List<String> imagePaths;

  final double price;
  final List<Color> colors;
  final String category;
  final double rate;

  Product({
    required this.title,
    required this.description,
    // required this.image,
    required this.price,
    required this.colors,
    required this.category,
    required this.rate,
    required this.imagePaths,
  });
}

final List<Product> products = [
  Product(
    title: "Wireless Headphones",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    imagePaths: [
      "assets/images/img2.jpg",
      "assets/images/beauty.png",
      "assets/images/img3.jpg",
      "assets/images/img1.jpg",
      "assets/images/img4.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Headphones",
    rate: 4.8,
  ),
];
//   Product(
//     title: "Woman Sweter",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
//     image: "assets/images/sweet.png",
//     price: 120,
//     colors: [
//       Colors.brown,
//       Colors.red,
//       Colors.pink,
//     ],
//     category: "Woman Fashion",
//     rate: 4.8,
//   ),
//   Product(
//     title: "Smart Watch",
//     description:
//         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
//     image: "assets/images/miband.jpg",
//     price: 55,
//     colors: [
//       Colors.black,
//     ],
//     category: "Watch",
//     rate: 4.8,
//   ),
// ];
