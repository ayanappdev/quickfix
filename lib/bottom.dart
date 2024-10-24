import 'package:flutter/material.dart';
import 'home.dart';  // Ensure this is the correct path to your HomeScreen

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
    // You can add more cases here for other navigation actions
    // case 1:
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => RestaurantScreen()),
    //   );
    //   break;
    // Add cases for Notifications and Bookings if you have those screens
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFDD301),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.3),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          label: 'Restaurants',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Bookings',
        ),
      ],
    );
  }
}
