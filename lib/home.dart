import 'dart:async';
import 'grid.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import the booking.dart file
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package for slider dots

import 'appbar.dart';
import 'bottom.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> restaurants = [
    'DelFrio',
    'Kababjees',
    'Kolachi',
    'Burger.com',
  ];

  List<String> filteredRestaurants = [];
  bool _isSearching = false;
  String _selectedCategory = '';
  bool _showSlider = true;
  bool _showWelcomeText = true;

  // Slider variables
  PageController _sliderPageController = PageController();
  int _currentPage = 0;
  Timer? _sliderTimer;

  // PageView controller for bottom navigation
  PageController _pageController = PageController();
  int _selectedIndex = 0; // Track selected bottom nav item

  @override
  void initState() {
    super.initState();
    filteredRestaurants = restaurants;

    // Start the slider animation
    _sliderTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _sliderPageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _sliderPageController.dispose();
    _pageController.dispose();
    _sliderTimer?.cancel();
    super.dispose();
  }

  void _filterRestaurants(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      filteredRestaurants = restaurants
          .where((restaurant) =>
              restaurant.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _showSlider = false;
      _showWelcomeText = false;

      if (category == 'All') {
        filteredRestaurants = ['Kababjees', 'Burger.com', 'DelFrio', 'Kolachi'];
      } else if (category == 'Burger') {
        filteredRestaurants = ['Kababjees', 'Burger.com'];
      } else if (category == 'Pasta') {
        filteredRestaurants = ['DelFrio'];
      } else if (category == 'Pizza') {
        filteredRestaurants = ['DelFrio', 'Kababjees'];
      } else if (category == 'Desi') {
        filteredRestaurants = ['Kolachi', 'Kababjees'];
      } else {
        filteredRestaurants = ['DelFrio', 'Kolachi'];
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Move the PageView to the tapped page
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Using the custom AppBar
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomePage(),
          _buildFavoritesPage(),
          _buildBookingsPage(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFDD301),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Home Page
  Widget _buildHomePage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
          ],
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SearchBarDelegate(
              onChanged: _filterRestaurants,
              isSearching: _isSearching,
            ),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (!_isSearching && _showWelcomeText)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Welcome to ReservEat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 5),
                if (!_isSearching && _showSlider)
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: PageView(
                              controller: _sliderPageController,
                              children: [
                                Image.asset('lib/assets/images/temp.jpg',
                                    fit: BoxFit.cover),
                                Image.asset('lib/assets/images/temp2.jpg',
                                    fit: BoxFit.cover),
                                Image.asset('lib/assets/images/img.png',
                                    fit: BoxFit.cover),
                                Image.asset('lib/assets/images/kbjs.png',
                                    fit: BoxFit.cover),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _sliderPageController,
                            count: 4,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Colors.yellow,
                              dotColor: Colors.grey,
                              dotHeight: 8.0,
                              dotWidth: 8.0,
                              expansionFactor: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                if (!_isSearching)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Sort by Category',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                if (!_isSearching)
                  Container(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryBox(
                          icon: Icons.dinner_dining,
                          text: 'All',
                          isSelected: _selectedCategory == 'All',
                          onTap: () => _onCategorySelected('All'),
                        ),
                        SizedBox(width: 10),
                        CategoryBox(
                          icon: Icons.local_pizza,
                          text: 'Pizza',
                          isSelected: _selectedCategory == 'Pizza',
                          onTap: () => _onCategorySelected('Pizza'),
                        ),
                        SizedBox(width: 10),
                        CategoryBox(
                          icon: Icons.dinner_dining,
                          text: 'Pasta',
                          isSelected: _selectedCategory == 'Pasta',
                          onTap: () => _onCategorySelected('Pasta'),
                        ),
                        SizedBox(width: 10),
                        CategoryBox(
                          icon: Icons.fastfood,
                          text: 'Burger',
                          isSelected: _selectedCategory == 'Burger',
                          onTap: () => _onCategorySelected('Burger'),
                        ),
                        SizedBox(width: 10),
                        CategoryBox(
                          icon: Icons.restaurant_menu,
                          text: 'Desi',
                          isSelected: _selectedCategory == 'Desi',
                          onTap: () => _onCategorySelected('Desi'),
                        ),
                        SizedBox(width: 10),
                        CategoryBox(
                          icon: Icons.coffee_sharp,
                          text: 'Coffee',
                          isSelected: _selectedCategory == 'Coffee',
                          onTap: () => _onCategorySelected('Coffee'),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 10),
                if (filteredRestaurants.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      String imagePath;
                      switch (filteredRestaurants[index]) {
                        case 'Kolachi':
                          imagePath = 'lib/assets/images/img.png';
                          break;
                        case 'Kababjees':
                          imagePath = 'lib/assets/images/kbjs.png';
                          break;
                        case 'Burger.com':
                          imagePath = 'lib/assets/images/temp2.jpg';
                          break;
                        default:
                          imagePath = 'lib/assets/images/temp.jpg';
                      }
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                imagePath,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              filteredRestaurants[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Timings: 12:00 PM - 11:00 PM',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < 4
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: index < 4
                                          ? Color(0xFFFDD301)
                                          : Colors.white,
                                      size: 20,
                                    );
                                  }),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            GridScreen(), // Navigate to BookingScreen
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Color(0xFFFDD301),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text('Book Now'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          if (_isSearching && filteredRestaurants.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'No restaurant found',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Favorites Page
  Widget _buildFavoritesPage() {
    return Center(
      child: Text('Favorites', style: TextStyle(color: Colors.white)),
    );
  }

  // Bookings Page
  Widget _buildBookingsPage() {
    return Center(
      child: Text('Bookings', style: TextStyle(color: Colors.white)),
    );
  }

  // Profile Page
  Widget _buildProfilePage() {
    return Center(
      child: Text('Profile', style: TextStyle(color: Colors.white)),
    );
  }
}



class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final ValueChanged<String> onChanged;
  final bool isSearching;

  SearchBarDelegate({
    required this.onChanged,
    required this.isSearching,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Search for Restaurants',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80.0; // Height of the search bar

  @override
  double get minExtent => 80.0; // Height of the search bar

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CategoryBox extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryBox({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 100, // Width of each box
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xFFFDD301) : Colors.blueGrey[400],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white, size: 35),
            SizedBox(height: 8),
            Text(
              widget.text,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
