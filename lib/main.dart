import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickfix/Screens/Category_Screen/Beauty_screen.dart';
import 'package:quickfix/Screens/Category_Screen/Mobile_screen.dart';
import 'package:quickfix/Screens/Category_Screen/Pc_screen.dart';
import 'package:quickfix/Screens/Category_Screen/Shoes_screen.dart';
import 'package:quickfix/Screens/Category_Screen/category.dart';
import 'package:quickfix/Screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
      await Firebase.initializeApp(
   options: const FirebaseOptions(
            apiKey: "AIzaSyANqBAVbgYpao3nK-TIkNdIiK22Pmwnjc4",
            appId: "1:1054436991649:web:78643b0c5f80ba08d486e0",
            messagingSenderId: "1054436991649",
            projectId: "quick-fix-b2d8d")
  ); 
  print("successfully connected");
  } catch (e) {
    // ignore: prefer_interpolation_to_compose_strings
debugPrint("Errrorrrrrrrrrrrr ------------->>>>>>> $e");

  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/shoes': (context) => ShoesScreen(),
        '/beauty': (context) => BeautyScreen(),
        '/pc': (context) => PcScreen(),
        '/mobile': (context) => MobileScreen(),
        '/all_categories': (context) => CategoryScreen(),
      },
    );
  }
}
