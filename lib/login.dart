// ignore_for_file: prefer_final_fields


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickfix/home.dart';
import 'package:quickfix/registerrestaurant.dart';
import 'package:quickfix/role.dart';
import 'signup.dart'; // Update with the correct path

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _obscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    print(_emailController.text);
    print(_passwordController.text);
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text);
        User user = FirebaseAuth.instance.currentUser!;
        print(user.uid);
        // User? user = userCredential.user;
        if (user != null) {
          // Retrieve user role from Firestore
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get();
          print(userData.data());

          String role = userData['role'];

          if (role == 'user') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(), // Navigate to BookingScreen
              ),
            ); // Navigate to Home screen
          } else if (role == 'res') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    RegisterRestaurantScreen(), // Navigate to BookingScreen
              ),
            ); // Navigate to Register Restaurant screen
          }
        }
      } catch (e) {
        print(e);
        _showErrorDialog(
            'Invalid credentials. Please enter correct email or password.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Container (uncomment if needed)
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(32),
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("lib/assets/images/resereat.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),
          // Logo at the top
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 50), // Adjust padding as needed
              child: Image.asset(
                'lib/assets/images/resereat.png', // Update with your logo image path
                height: 120, // Adjust the height as needed
              ),
            ),
          ),
          // Text at the bottom
          Container(
            padding: const EdgeInsets.only(top: 750, left: 60, right: 50),
            child: const Text(
              'All Rights Reserved. ReservEat Inc. (2024)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 670, right: 80, left: 80),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChooseRoleScreen(), // Navigate to BookingScreen
                  ),
                ); // Navigate to role.dart
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.black, // Change the button's background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(160.0, 50.0),
                foregroundColor: Colors.white, // Change the text color
                elevation: 5, // Change the button's elevation
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GO BACK',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          // Login Container
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Container(
                height: 430,
                width: 350,
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFFDD301), // Apply the hex color code here
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.only(top: 40, left: 40),
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 0, left: 55),
                        child: Text(
                          'Sign In to the',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 32, left: 53),
                        child: Text(
                          'ReservEat',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baskerville',
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Text(
                          'Email',
                          style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, right: 50),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: 'xyz@domain.com',
                            suffixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 180),
                        child: Text(
                          'Password',
                          style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 200, right: 50),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: '******',
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 280, right: 50),
                        child: ElevatedButton(
                          onPressed: _loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minimumSize: Size(160.0, 50.0),
                            foregroundColor: Colors.white,
                            elevation: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOG IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 320, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an Account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MySignup()),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
