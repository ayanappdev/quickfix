import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List onBoardingData = [
    {
      "image": "assets/Lottie/images/pic1.gif",
      "title": "Welcome To QuickFix",
      "description": "Your Go-To Solution for Quick Repairs"
    },
    {
      "image": "assets/Lottie/images/pic2.gif",
      "title": "Get Started Now",
      "description": "Convenient Services at your Finger Tips"
    },
    {
      "image": "assets/Lottie/images/pic3.gif",
      "title": "Trusted By Thousands",
      "description": "Hear What Our Customers Say"
    },
  ];
  Color whiteColor = Colors.white;
  Color greenColor = Color.fromARGB(220, 69, 76, 70);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("OnBoarding Example"),
      ),
    );
  }
}
