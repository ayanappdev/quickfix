import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickfix/Widgets/hiddendrawer_screen.dart';
import 'package:quickfix/Screens/Home_Screen/home_screen.dart';
import 'package:quickfix/auth/auth_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If user is logged in, force logout
      FirebaseAuth.instance.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, show HomeScreen
            return HiddenDrawer();
          } else {
            // User is not logged in, show AuthPage
            return AuthPage();
          }
        },
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:quickfix/Screens/home_screen.dart';

// import 'package:quickfix/auth/auth_page.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return HomeScreen();
//           } else {
//             return AuthPage();
//           }
//         },
//       ),
//     );
//   }
// }
