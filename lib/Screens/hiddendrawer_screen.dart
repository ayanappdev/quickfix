import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:quickfix/Screens/home_screen.dart';
import 'package:quickfix/Screens/login_Screen.dart';
import 'package:quickfix/Screens/profilesetting-screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  final AuthService _auth = AuthService();
  // Create an AuthService instance
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void handleLogout() async {
    try {
      await _auth.signOut();
      // After successful logout, navigate to the login screen (or another appropriate screen)
      // Assuming you have a login route
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    showRegisterPage: (toggleScreen),
                  )),
          (Route<dynamic> route) => false);
    } catch (error) {
      // Handle any logout errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
        ),
      );
    }
  }

  List<ScreenHiddenDrawer> _pages = [];
  final myTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "HomePage",
          // colorLineSelected: Colors.orange,
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Color.fromARGB(255, 27, 111, 97),
        ),
        HomeScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Profile",
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Color.fromARGB(255, 27, 111, 97),
        ),
        ProfileSetting(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Logout",
          baseStyle: myTextStyle,
          selectedStyle: TextStyle(),
          colorLineSelected: Color.fromARGB(255, 27, 111, 97),
        ),
        ProfileSetting(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorAppBar: Color.fromARGB(255, 27, 111, 97),
      backgroundColorMenu: Color.fromARGB(210, 85, 148, 133),
      initPositionSelected: 0,
      isTitleCentered: true,
      slidePercent: 60,
      leadingAppBar: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      styleAutoTittleName:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
