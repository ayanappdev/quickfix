import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:quickfix/Screens/Category_Screen/category.dart';
import 'package:quickfix/Screens/Home_Screen/home_screen.dart';
import 'package:quickfix/Screens/Authentication_Screen/login_Screen.dart';
import 'package:quickfix/Screens/Orders%20Screen/order_Screen.dart';
import 'package:quickfix/Screens/main_screen.dart';
import 'package:quickfix/Screens/profile_screen.dart';
import 'package:quickfix/Screens/profilesetting-screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  final AuthService _auth = AuthService();
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void handleLogout() async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(
            showRegisterPage: toggleScreen,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error logging out: $error'),
        ),
      );
    }
  }

  List<ScreenHiddenDrawer> _pages = [];
  final myTextStyle = const TextStyle(
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
          baseStyle: myTextStyle,
          selectedStyle: const TextStyle(),
          colorLineSelected: const Color.fromARGB(255, 27, 111, 97),
        ),
        const HomeScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Profile",
          baseStyle: myTextStyle,
          selectedStyle: const TextStyle(),
          colorLineSelected: const Color.fromARGB(255, 27, 111, 97),
        ),
        const ProfileScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Categories",
          baseStyle: myTextStyle,
          selectedStyle: const TextStyle(),
          colorLineSelected: const Color.fromARGB(255, 27, 111, 97),
        ),
        CategoryScreen(),
      ),
        ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Orders",
          baseStyle: myTextStyle,
          selectedStyle: const TextStyle(),
          colorLineSelected: const Color.fromARGB(255, 27, 111, 97),
        ),
        const OrderScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Logout",
          baseStyle: myTextStyle,
          selectedStyle: const TextStyle(),
          colorLineSelected: const Color.fromARGB(255, 27, 111, 97),
        ),
        LogoutScreen(handleLogout: handleLogout),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorAppBar: const Color.fromARGB(255, 27, 111, 97),
      backgroundColorMenu: const Color.fromARGB(210, 85, 148, 133),
      initPositionSelected: 0,
      isTitleCentered: true,
      slidePercent: 60,
      leadingAppBar: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      styleAutoTittleName:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  final Function handleLogout;

  const LogoutScreen({Key? key, required this.handleLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleLogout();
    return Container();
  }
}
