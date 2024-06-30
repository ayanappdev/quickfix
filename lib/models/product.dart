import 'package:flutter/material.dart';

class Subcategory {
  final String title;
  final String description;
  final double price;

  Subcategory({
    required this.title,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }
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
  final String categoryTitle;

  Product({
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.price,
    required this.colors,
    required this.category,
    required this.rate,
    required this.subcategories,
    required this.categoryTitle,
  });
}

final List<Product> products = [
  Product(
    categoryTitle: 'Wheels & Tires',
    title: "Flat Tire & Repair",
    description: "Essential TLC for your bike. We tackle chain cleaning & lubrication, tire pressure checks & adjustments, and basic brake inspections. Ensure smooth performance and prevent future problems.",
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
          title: "Flat Tire Repair", description: "Repair of flat tires", price: 600),
      Subcategory(
          title: "Inner Tube Replacement", description: "Replacement of inner tubes", price: 800),
      Subcategory(
          title: "Tire Replacement", description: "Full tire replacement", price: 1200),
      Subcategory(
          title: "Wheel Truing & Spoke Tensioning", description: "Adjustment of wheel alignment and spoke tension", price: 1000),
    ],
  ),
  Product(
    categoryTitle: 'Electrical',
    title: "Light Repair & Replacement",
    description: "Keep your bike's lights shining bright. We handle repairs and replacements for headlights, taillights, and brake lights. Ensure safe nighttime visibility.",
    imagePaths: [
      "assets/images/el1.jpg",
      "assets/images/el2.jpg",
      "assets/images/el3.jpg",
      "assets/images/el4.jpg",
      "assets/images/el5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Electrical",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Light Repair & Replacement", description: "Fix flickering lights or upgrade with new ones for optimal nighttime visibility.", price: 700),
      Subcategory(
          title: "Battery Replacement", description: "Ensure reliable power with a fresh battery replacement.", price: 900),
      Subcategory(
          title: "Wiring Check & Repair", description: "Diagnose and fix electrical wiring issues to keep your bike's lights functioning properly.", price: 850),
    ],
  ),
  Product(
    categoryTitle: 'Brakes',
    title: "Brake Pad Replacement",
    description: "Maintain optimal stopping power for safe riding. We offer services to keep your brakes functioning smoothly.",
    imagePaths: [
      "assets/images/bk1.jpg",
      "assets/images/bk2.jpg",
      "assets/images/bk3.jpg",
      "assets/images/bk4.jpg",
      "assets/images/bk5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Brakes",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Brake Pad Replacement", description: "New pads for reliable stopping power.", price: 600),
      Subcategory(
          title: "Brake Caliper Adjustment & Repair", description: "Ensure proper brake engagement.", price: 750),
      Subcategory(
          title: "Hydraulic Brake Service", description: "Maintain fluid levels & system function.", price: 950),
    ],
  ),
  Product(
    categoryTitle: 'Drivetrain',
    title: "Chain Repair & Replacement",
    description: "Keep your gears shifting smoothly. We service chains, cassettes, and bottom brackets.",
    imagePaths: [
      "assets/images/dr1.jpg",
      "assets/images/dr2.jpg",
      "assets/images/dr3.jpg",
      "assets/images/dr4.jpg",
      "assets/images/dr5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Drivetrain",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Chain Replacement & Adjustment", description: "Replace worn chains and ensure proper tension.", price: 650),
      Subcategory(
          title: "Cassette & Chainring Replacement", description: "Upgrade or replace worn cassette and chainrings.", price: 800),
      Subcategory(
          title: "Bottom Bracket Service", description: "Maintain smooth pedaling with proper bottom bracket service.", price: 950),
    ],
  ),
  Product(
    categoryTitle: 'General Maintenance',
    title: "Bike Tune-Up",
    description: "Optimize your bike's performance. We offer essential checkups and adjustments.",
    imagePaths: [
      "assets/images/dr1.jpg",
      "assets/images/dr2.jpg",
      "assets/images/dr3.jpg",
      "assets/images/dr4.jpg",
      "assets/images/dr5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "General Maintenance",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Tire Checks & Adjustments", description: "Ensure proper inflation and alignment for a smooth ride.", price: 500),
      Subcategory(
          title: "Gear Adjustment & Derailleur Tuning", description: "Fine-tune your gears for seamless shifting.", price: 600),
      Subcategory(
          title: "Air Pressure Check & Inflation", description: "Maintain optimal tire pressure for safety and performance.", price: 400),
    ],
  ),
  Product(
    categoryTitle: 'Components',
    title: "Component Replacement",
    description: "Maintain optimal component function. We service shifters, derailleurs, and headsets.",
    imagePaths: [
      "assets/images/dr1.jpg",
      "assets/images/dr2.jpg",
      "assets/images/dr3.jpg",
      "assets/images/dr4.jpg",
      "assets/images/dr5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Components",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Shifter & Derailleur Adjustment", description: "Fine-tune your shifters and derailleurs for smooth gear changes.", price: 700),
      Subcategory(
          title: "Headset Adjustment", description: "Eliminate headset play for a comfortable and precise ride.", price: 500),
      Subcategory(
          title: "Pedal Service", description: "Maintain smooth pedaling with proper pedal service.", price: 450),
    ],
  ),
  Product(
    categoryTitle: 'Safety',
    title: "Safety Check",
    description: "Ride with confidence. We offer essential safety checks and installations.",
    imagePaths: [
      "assets/images/dr1.jpg",
      "assets/images/dr2.jpg",
      "assets/images/dr3.jpg",
      "assets/images/dr4.jpg",
      "assets/images/dr5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Safety",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Brake System Safety Check", description: "Ensure your brakes function properly for safe stopping.", price: 700),
      Subcategory(
          title: "Reflective Gear Installation", description: "Increase visibility with reflective gear installation.", price: 500),
      Subcategory(
          title: "Helmet Inspection & Fitting", description: "Get a helmet inspection and proper fit for optimal protection.", price: 600),
    ],
  ),
  Product(
    categoryTitle: 'Accessories',
    title: "Accessory Installation",
    description: "Customize your ride. We offer installation for essential accessories.",
    imagePaths: [
      "assets/images/dr1.jpg",
      "assets/images/dr2.jpg",
      "assets/images/dr3.jpg",
      "assets/images/dr4.jpg",
      "assets/images/dr5.jpg",
    ],
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Accessories",
    rate: 4.8,
    subcategories: [
      Subcategory(
          title: "Bike Rack Installation", description: "Transport your bike conveniently with a bike rack installation.", price: 900),
      Subcategory(
          title: "Lock Installation", description: "Enhance bike security with a professionally installed lock.", price: 400),
      Subcategory(
          title: "Fenders & Mudguards Installation", description: "Stay protected from the elements with fender and mudguard installation.", price: 600),
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
