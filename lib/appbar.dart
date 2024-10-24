import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

import 'signup.dart';

import 'profile.dart';
import 'package:flutter/material.dart';
import 'role.dart'; // Ensure this is the correct path to your Role screen

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'ReservEat',
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontFamily: 'Baskerville',
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xFFFDD301),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('lib/assets/images/Reserveat.jpg'),
      ),
      actions: <Widget>[
        PopupMenuButton<String>(
          icon: Icon(Icons.person, color: Colors.black, size: 40),
          onSelected: (String value) {
            switch (value) {
              case 'Login':
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLogin()));
              case 'Signup':
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MySignup())); // Navigating to RoleScreen
                break;
              case 'Profile':
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
                // Handle profile action
                break;
              case 'Logout':
                logout(context);
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Login', 'Signup', 'Profile', 'Logout'}
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyLogin(),
      ),
    );
  }
}
