import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the SplashScreen file
// Import the MyLogin widget
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBCQ3djojEykESYx7OsNxCBf45etjHyOYo",
        appId: "1:231033188701:android:2b06e77c2fb61d8ad7b8b4",
messagingSenderId: "231033188701",
        projectId: "reserve-eat",
      ),
    );
    print('Firebase connected successfully');
    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'ReservEat',
      debugShowCheckedModeBanner: false,
      home: SplashScreen());
}
