import 'package:quickfix/role.dart';
import 'package:flutter/material.dart';
import 'signuprest.dart'; // Update with the correct path

class MyLoginrest extends StatefulWidget {
  const MyLoginrest({Key? key}) : super(key: key);

  @override
  _MyLoginrestState createState() => _MyLoginrestState();
}

class _MyLoginrestState extends State<MyLoginrest> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
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
                height: 120, // Adjust the height as neede
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
            padding: const EdgeInsets.only(top: 670, right: 80,left: 80),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseRoleScreen())); // Navigate to login.dart
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .black, // Change the button's background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(160.0, 50.0),
                foregroundColor:
                Colors.white, // Change the text color
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
                height: 420,
                width: 350,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFFDD301), // Apply the hex color code here
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.only(top: 40, left: 40),
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 0, left: 55),
                      child: Text(
                        'Sign In to your',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 32, left: 52),
                      child: Text(
                        'Restaurant',
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
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'xyz@domain.com',
                          suffixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 280, right: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, 'registerrestaurant', (route)=> false,);// Add your button's action here// Add your button's action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .black, // Change the button's background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(160.0, 50.0),
                          foregroundColor:
                          Colors.white, // Change the text color
                          elevation: 5, // Change the button's elevation
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
                      padding: const EdgeInsets.only(top: 340, right: 50),
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
                                  builder: (context) => MySignuprest(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.blueAccent,
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
        ],
      ),
    );
  }
}
