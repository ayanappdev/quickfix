import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quickfix/Screens/Category_Screen/category.dart';
import 'package:quickfix/Screens/Favourite_Screen/favourite_screen.dart';
import 'package:quickfix/Screens/Home_Screen/home_screen.dart';
import 'package:quickfix/Screens/profile_screen.dart';
import 'package:quickfix/Widgets/hiddendrawer_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned.fill(
            child: GestureDetector(
              onTap:
                  () {}, // Handle tap events to prevent interference with the navigation bar
              child:
                  HiddenDrawer(), // Display HiddenDrawer on top of the content
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.black,
        color: const Color.fromARGB(255, 220, 220, 220),
        items: [
          Icon(Icons.home),
          Icon(Icons.category_outlined),
          Icon(Icons.favorite_border),
          Icon(Icons.person_2_outlined)
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:quickfix/Screens/Category_Screen/category.dart';
// import 'package:quickfix/Screens/Favourite_Screen/favourite_screen.dart';
// import 'package:quickfix/Screens/home_screen.dart';
// import 'package:quickfix/Screens/profile_screen.dart';
// import 'package:quickfix/Screens/hiddendrawer_screen.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     HomeScreen(),
//     CategoryScreen(),
//     FavouriteScreen(),
//     ProfileScreen(),
//   ];

//   void _onTabTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => _pages[index]));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           IndexedStack(
//             index: _selectedIndex,
//             children: _pages,
//           ),
//           Positioned.fill(
//             child:
//                 HiddenDrawer(), // Use Positioned.fill to ensure HiddenDrawer takes full screen size
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: CurvedNavigationBar(
//               animationDuration: Duration(milliseconds: 300),
//               backgroundColor: Colors.black,
//               color: const Color.fromARGB(255, 220, 220, 220),
//               items: [
//                 Icon(Icons.home),
//                 Icon(Icons.category_outlined),
//                 Icon(Icons.favorite_border),
//                 Icon(Icons.person_2_outlined)
//               ],
//               onTap: _onTabTapped,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
