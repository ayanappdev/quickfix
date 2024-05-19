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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Corrected
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
