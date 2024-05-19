// category.dart
class Category {
  final String title;
  final String image;

  Category({
    required this.title,
    required this.image,
  });
}

final List<Category> categories = [
  Category(title: "Tyre", image: "assets/images/tyre.png"),
  Category(title: "Brake", image: "assets/images/brake.png"),
  Category(title: "Chain", image: "assets/images/chain.png"),
  Category(title: "Light", image: "assets/images/light.png"),
];


// class Category {
//   final String title;
//   final String image;

//   Category({
//     required this.title,
//     required this.image,
//   });
// }

// final List<Category> categories = [
//   Category(title: "Shoes", image: "assets/images/shoes.jpg"),
//   Category(title: "Beauty", image: "assets/images/beauty.png"),
//   Category(title: "PC", image: "assets/images/pc.jpg"),
//   Category(title: "Mobile", image: "assets/images/mobile.jpg"),
//   Category(title: "Watch", image: "assets/images/watch.png"),
// ];