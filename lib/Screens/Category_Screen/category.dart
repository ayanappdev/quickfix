// all_categories_screen.dart
import 'package:flutter/material.dart';
import 'package:quickfix/models/category.dart';
import 'category.dart';

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
              String route;
              switch (categories[index].title) {
                case 'Shoes':
                  route = '/shoes';
                  break;
                case 'Beauty':
                  route = '/beauty';
                  break;
                case 'PC':
                  route = '/pc';
                  break;
                case 'Mobile':
                  route = '/mobile';
                  break;
                default:
                  route = '/';
              }
              Navigator.pushNamed(context, route);
            },
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(
                        255, 30, 134, 98), // Background color of the container
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Padding for the image
                    child: Image.asset(
                      categories[index].image,
                      fit: BoxFit
                          .contain, // Ensure the image fits within the container
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


// // all_categories_screen.dart
// import 'package:flutter/material.dart';
// import 'package:quickfix/models/category.dart';
// import 'category.dart';

// class CategoryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Categories'),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10.0,
//           crossAxisSpacing: 10.0,
//         ),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               String route;
//               switch (categories[index].title) {
//                 case 'Shoes':
//                   route = '/shoes';
//                   break;
//                 case 'Beauty':
//                   route = '/beauty';
//                   break;
//                 case 'PC':
//                   route = '/pc';
//                   break;
//                 case 'Mobile':
//                   route = '/mobile';
//                   break;
//                 default:
//                   route = '/';
//               }
//               Navigator.pushNamed(context, route);
//             },
//             child: Column(
//               children: [
//                 Container(
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color.fromARGB(255, 31, 113, 94),
//                     image: DecorationImage(
//                       image: AssetImage(categories[index].image),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   child: Padding(padding: EdgeInsets.all(8)),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   categories[index].title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
