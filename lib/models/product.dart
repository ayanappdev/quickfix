import 'package:flutter/material.dart';

class Subcategory {
  final String title;
  final String description;

  Subcategory({
    required this.title,
    required this.description,
  });
}

class Product {
  final String title;
  final String description;
  final List<String> imagePaths;
  final double price;
  final List<Color> colors;
  final String category;
  final double rate;
  final List<Subcategory> subcategories;

  Product({
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.price,
    required this.colors,
    required this.category,
    required this.rate,
    required this.subcategories,
  });
}

final List<Product> products = [
  Product(
    title: "Flat Tire & Repair ",
    description:
        "Essential TLC for your bike. We tackle chain cleaning & lubrication, tire pressure checks & adjustments, and basic brake inspections. Ensure smooth performance and prevent future problems.",
    imagePaths: [
      "assets/images/flattyre.jpg",
      "assets/images/ft1.jpg",
      "assets/images/ft2.jpg",
      "assets/images/ft3.jpg",
      "assets/images/ft4.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Headphones",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Flat Tire Repair", description: "Repair of flat tires"),
      Subcategory(
          title: "Inner Tube Replacement",
          description: "Replacement of inner tubes"),
      Subcategory(
          title: "Tire Replacement", description: "Full tire replacement"),
      Subcategory(
          title: "Wheel Truing & Spoke Tensioning",
          description: "Adjustment of wheel alignment and spoke tension"),
    ],
  ),
];
























// import 'package:flutter/material.dart';

// class Product {
//   final String title;
//   final String description;
//   final List<String> imagePaths;

//   final double price;
//   final List<Color> colors;
//   final String category;
//   final double rate;

//   Product({
//     required this.title,
//     required this.description,
//     // required this.image,
//     required this.price,
//     required this.colors,
//     required this.category,
//     required this.rate,
//     required this.imagePaths,
//   });
// }

// final List<Product> products = [
//   Product(
//     title: "Flat Tire Repair",
//     description:
//         "Essential TLC for your bike. We tackle chain cleaning & lubrication, tire pressure checks & adjustments, and basic brake inspections. Ensure smooth performance and prevent future problems.",
//     imagePaths: [
//       "assets/images/flattyre.jpg",
//       "assets/images/ft1.jpg",
//       "assets/images/ft2.jpg",
//       "assets/images/ft3.jpg",
//       "assets/images/ft4.jpg",
//     ],
//     price: 120,
//     colors: [
//       Colors.black,
//       Colors.blue,
//       Colors.orange,
//     ],
//     category: "Headphones",
//     rate: 4.8,
//   ),
// ];























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
