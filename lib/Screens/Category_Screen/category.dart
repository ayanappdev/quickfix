import 'package:flutter/material.dart';
import 'package:quickfix/models/category.dart';
import 'package:quickfix/models/product.dart';
import 'package:quickfix/Screens/product_screen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Product? selectedProduct;

              switch (categories[index].title) {
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
                    color: Color.fromARGB(255, 30, 134, 98), // Background color of the container
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Padding for the image
                    child: Image.asset(
                      categories[index].image,
                      fit: BoxFit.contain, // Ensure the image fits within the container
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  categories[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
