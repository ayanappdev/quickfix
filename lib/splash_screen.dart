import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickfix/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Column(
          children: [
            SizedBox(
              height: 300,
              child: LottieBuilder.network(
                  "https://lottie.host/cca94342-8430-43bf-9102-5c74739359d5/9lKsQl4huj.json"),
            ),
            // child: LottieBuilder.asset(
            //     "assets/Lottie/Animation - 1709512139288.lottie"))
          ],
        ),
        nextScreen: const HomeScreen(),
        splashIconSize: 300,
        animationDuration: Durations.long1,
        splashTransition: SplashTransition.slideTransition,
      ),
    );
  }
}
