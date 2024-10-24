import 'home.dart';
import 'package:flutter/material.dart';
import 'role.dart';
import 'registerrestaurant.dart';
//import 'login.dart';  // Import the MyLogin widget

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    Future.delayed(Duration(seconds: 5), () {
      _controller.forward();
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          ); // Navigate to the login route
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'lib/assets/images/resereat1.png',
              height: 250,
            )
            // Ensure this path is correct

            // Ensure the image path is correct
            ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
