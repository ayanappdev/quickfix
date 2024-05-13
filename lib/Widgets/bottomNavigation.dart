import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quickfix/Screens/Category_Screen/category.dart';
import 'package:quickfix/Screens/Favourite_Screen/favourite_screen.dart';
import 'package:quickfix/Screens/home_screen.dart';
import 'package:quickfix/Screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

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

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.black,
        color: const Color.fromARGB(255, 220, 220, 220),
        items: [
          Icon(Icons.home),
          Icon(Icons.category_outlined),
          Icon(Icons.favorite_border),
          Icon(Icons.person_2_outlined)
        ],
        onTap: _onTabTapped,
      ),
    );
  }
}
