// import 'package:flutter/material.dart';
// import 'package:quickfix/Screens/login_Screen.dart';

// // AuthService for handling authentication
// class AuthService {
//   Future<void> signOut() async {
//     // Implement your specific logout logic here
//     // This might involve clearing local storage, tokens, or making an API call
//     // to your backend for a more secure logout

//     // Example (replace with your actual implementation):
//     await Future.delayed(const Duration(seconds: 1)); // Simulate logout process
//     print('Successfully logged out!');
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const _HomeScreenBody();
//   }
// }

// class _HomeScreenBody extends StatefulWidget {
//   const _HomeScreenBody({Key? key}) : super(key: key);

//   @override
//   State<_HomeScreenBody> createState() => _HomeScreenBodyState();
// }

// class _HomeScreenBodyState extends State<_HomeScreenBody> {
//   final AuthService _auth = AuthService();

//   Future<void> handleLogout() async {
//     try {
//       await _auth.signOut();
//       // After successful logout, navigate to the login screen (or another appropriate screen)
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//             builder: (context) => LoginScreen(showRegisterPage: () {})),
//         (route) => false,
//       );
//     } catch (error) {
//       // Handle any logout errors gracefully
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error logging out: $error'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             tooltip: 'Logout',
//             onPressed: handleLogout,
//           ),
//         ],
//       ),
//       body: const Center(child: Text("Home")),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quickfix/Widgets/hiddendrawer_screen.dart';

import 'package:quickfix/Screens/Authentication_Screen/login_Screen.dart';
import 'package:quickfix/Widgets/bottomNavigation.dart';
import 'package:quickfix/Widgets/categories.dart';
import 'package:quickfix/Widgets/home_appbar.dart';
import 'package:quickfix/Widgets/home_slider.dart';
import 'package:quickfix/Widgets/product_card.dart';
import 'package:quickfix/Widgets/search_field.dart';
import 'package:quickfix/constants.dart';
import 'package:quickfix/models/product.dart';

// Assuming you have an AuthService class (or similar) for authentication
class AuthService {
  Future<void> signOut() async {
    // Implement your specific logout logic here
    // This might involve clearing local storage, tokens, or making an API call
    // to your backend for a more secure logout

    // Example (replace with your actual implementation):
    await Future.delayed(const Duration(seconds: 1)); // Simulate logout process
    print('Successfully logged out!');
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  // Create an AuthService instance
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void handleLogout() async {
    try {
      await _auth.signOut();
      // After successful logout, navigate to the login screen (or another appropriate screen)
      // Assuming you have a login route
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    showRegisterPage: (toggleScreen),
                  )),
          (Route<dynamic> route) => false);
    } catch (error) {
      // Handle any logout errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
        ),
      );
    }
  }

  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kscaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(height: 20),
                const SearchField(),
                const SizedBox(height: 20),
                HomeSlider(
                  onChange: (value) {
                    setState(() {
                      currentSlide = value;
                    });
                  },
                  currentSlide: currentSlide,
                ),
                const SizedBox(height: 20),
                Categories(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Special For You",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See all"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
