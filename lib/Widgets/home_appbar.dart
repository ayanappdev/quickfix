import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:quickfix/Screens/Category_Screen/category.dart';
import 'package:quickfix/Screens/Favourite_Screen/favourite_screen.dart';
import 'package:quickfix/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen()),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 45, 131, 95),
            padding: const EdgeInsets.all(10),
          ),
          iconSize: 25,
          icon: const Icon(
            Ionicons.grid_outline,
            color: Colors.white,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavouriteScreen()),
            );
          },
          style: IconButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 45, 131, 95),
            padding: const EdgeInsets.all(10),
          ),
          iconSize: 25,
          icon: const Icon(
            Ionicons.heart_outline,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 45, 131, 95),
            padding: const EdgeInsets.all(10),
          ),
          iconSize: 25,
          icon: const Icon(
            Ionicons.cart_outline,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:quickfix/Screens/Category_Screen/category.dart';
// import 'package:quickfix/Screens/Favourite_Screen/favourite_screen.dart';
// import 'package:quickfix/constants.dart';
// // import 'package:shop_example/constants.dart';

// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => CategoryScreen()));
//           },
//           style: IconButton.styleFrom(
//             backgroundColor: Color.fromARGB(255, 45, 131, 95),
//             padding: const EdgeInsets.all(10),
//           ),
//           iconSize: 25,
//           icon: const Icon(
//             Ionicons.grid_outline,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(
//           width: 247,
//         ),
//         IconButton(
//           onPressed: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => FavouriteScreen()));
//           },
//           style: IconButton.styleFrom(
//             backgroundColor: Color.fromARGB(255, 45, 131, 95),
//             padding: const EdgeInsets.all(10),
//           ),
//           iconSize: 25,
//           icon: const Icon(
//             Ionicons.heart_outline,
//             color: Colors.white,
//           ),
//         ),
//         IconButton(
//           onPressed: () {},
//           style: IconButton.styleFrom(
//             backgroundColor: Color.fromARGB(255, 45, 131, 95),
//             padding: const EdgeInsets.all(10),
//           ),
//           iconSize: 25,
//           icon: const Icon(
//             Ionicons.cart_outline,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }
