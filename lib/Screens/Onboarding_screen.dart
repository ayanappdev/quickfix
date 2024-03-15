import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickfix/Screens/login_Screen.dart';
import 'package:quickfix/auth/main_page.dart';

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
  Color darkgreen = Color.fromARGB(255, 27, 111, 97);
  PageController pageController = PageController();
  int currentPage = 0;
  continueMethod() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainPage()),
        (Route<dynamic> route) => false);
  }

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

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
            onPageChanged: onChanged,
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (currentPage == (onBoardingData.length - 1))
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkgreen,
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: continueMethod,
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: whiteColor,
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(onBoardingData.length,
                            (index) {
                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            height: 10,
                            width: (index == currentPage) ? 15 : 10,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == currentPage)
                                  ? darkgreen
                                  : Colors.grey,
                            ),
                          );
                        }),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
