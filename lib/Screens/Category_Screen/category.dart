import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quickfix/constants.dart';
import 'package:quickfix/models/category.dart';
import 'package:quickfix/models/product.dart';
import 'package:quickfix/Screens/product_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category> filteredCategories = categories;
  TextEditingController searchController = TextEditingController();

  void filterCategories(String query) {
    List<Category> filtered = categories
        .where((category) =>
            category.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      filteredCategories = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kcontentColor,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 5,
              ),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: "Search...",
                        border: InputBorder.none,
                      ),
                      onChanged: filterCategories,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 1.5,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Ionicons.options_outline,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: filteredCategories.isEmpty
                ? Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Product? selectedProduct;

                          switch (filteredCategories[index].title) {
                            case 'Wheels & Tires':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Wheels & Tires',
                                orElse: () => products[0],
                              );
                              break;
                            case 'Electrical':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Electrical',
                                orElse: () => products[1],
                              );
                              break;
                            case 'Brake':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Brakes',
                                orElse: () => products[2],
                              );
                              break;
                            case 'Drivetrain':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Drivetrain',
                                orElse: () => products[2],
                              );
                              break;
                            case 'General Maintenance':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'General Maintenance',
                                orElse: () => products[2],
                              );
                              break;
                            case 'Components':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Components',
                                orElse: () => products[2],
                              );
                              break;
                            case 'Safety':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Safety',
                                orElse: () => products[2],
                              );
                              break;
                            case 'Accessories':
                              selectedProduct = products.firstWhere(
                                (product) => product.categoryTitle == 'Accessories',
                                orElse: () => products[2],
                              );
                              break;
                            // Add more cases here for other categories as needed
                            default:
                              selectedProduct = null;
                          }

                          if (selectedProduct != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(product: selectedProduct!),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 30, 134, 98), // Background color of the container
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10), // Padding for the image
                                child: Image.asset(
                                  filteredCategories[index].image,
                                  fit: BoxFit.contain, // Ensure the image fits within the container
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              filteredCategories[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
