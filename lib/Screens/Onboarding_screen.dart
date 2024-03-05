import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List onBoardingData = [
    {
      "image": "assets/images/pic1.gif",
      "title": "Welcome To QuickFix",
      "description": "Your Go-To Solution for Quick Repairs"
    },
    {
      "image": "assets/images/pic2.gif",
      "title": "Get Started Now",
      "description": "Convenient Services at your Finger Tips"
    },
    {
      "image": "assets/images/pic3.gif",
      "title": "Trusted By Thousands",
      "description": "Hear What Our Customers Say"
    },
  ];
  Color whiteColor = Colors.white;
  Color greenColor = Color.fromARGB(220, 69, 76, 70);
  PageController pageController = PageController();

  continueMethod() {}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: continueMethod,
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: onBoardingData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    onBoardingData[index]['image'],
                  ),
                  Text(
                    onBoardingData[index]['title'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    onBoardingData[index]['description'],
                    style: TextStyle(
                        color: greenColor, fontWeight: FontWeight.w300),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
