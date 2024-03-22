import 'package:flutter/material.dart';
import 'package:quickfix/Screens/login_Screen.dart';

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
  final AuthService _auth = AuthService(); // Create an AuthService instance

  void handleLogout() async {
    try {
      await _auth.signOut();
      // After successful logout, navigate to the login screen (or another appropriate screen)
      // Assuming you have a login route
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    showRegisterPage: () {},
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:
                handleLogout, // Call the handleLogout function for logout action
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const Center(child: Text("Home")),
    );
  }
}
