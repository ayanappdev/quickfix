
import 'package:flutter/material.dart';
import 'package:quickfix/signup.dart';
import 'package:quickfix/signuprest.dart';
import 'loginrest.dart';
import 'login.dart';

class ChooseRoleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Choose Role',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFDD301), // Set app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Who are you using as:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MySignup())); // Navigate to login.dart
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Set button color to black
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: Text(
                'User',
                style: TextStyle(fontSize: 22, color: Color(0xFFFDD301)),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MySignuprest())); // Navigate to loginrest.dart
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Set button color to black
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              ),
              child: Text(
                'Restaurant Owner',
                style: TextStyle(fontSize: 22, color: Color(0xFFFDD301)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
