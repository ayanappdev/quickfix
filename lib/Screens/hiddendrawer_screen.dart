import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:quickfix/Screens/home_screen.dart';
import 'package:quickfix/Screens/profilesetting-screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "HomePage",
            // colorLineSelected: Colors.orange,
            baseStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            selectedStyle: TextStyle()),
        HomeScreen(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: "Profile",
            baseStyle: TextStyle(),
            selectedStyle: TextStyle()),
        ProfileSetting(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorAppBar: Color.fromARGB(255, 27, 111, 97),
      backgroundColorMenu: Color.fromARGB(170, 27, 111, 97),
      initPositionSelected: 0,
      isTitleCentered: true,
      leadingAppBar: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      styleAutoTittleName:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
