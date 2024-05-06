import 'package:flutter/material.dart';

class AuthService {
  // Method to perform logout
  Future<void> logout(BuildContext context) async {
    // Display circular progress indicator
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Logging out..."),
          ],
        ),
      ),
    );

    // Simulate logout process with a delay
    await Future.delayed(Duration(seconds: 2));

    // Close the dialog
    Navigator.of(context, rootNavigator: true).pop();

    // Navigate to login screen
    Navigator.of(context).pushReplacementNamed(
        '/loginScreen'); // Replace '/login' with your login route
  }
}
