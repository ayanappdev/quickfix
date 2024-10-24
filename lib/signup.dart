import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart'; // Update with the correct path

final formkey = GlobalKey<FormState>();

class MySignup extends StatefulWidget {
  const MySignup({Key? key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  TextEditingController userr = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pw = new TextEditingController();
  @override
  void dispose() {
    email.dispose();
    pw.dispose();
    userr.dispose();
    super.dispose();
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
            padding: const EdgeInsets.only(top: 700, left: 60, right: 50),
            child: Text(
              'All Rights Reserved. ReservEat Inc. (2024)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // Signup Container
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Center(
              child: Container(
                height: 480,
                width: 350,
                decoration: BoxDecoration(
                  color: Color(0xFFFDD301), // Apply the hex color code here
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.only(top: 40, left: 40),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        'UserName',
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60, right: 50),
                      child: TextField(
                        controller: userr,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'john',
                          suffixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 140),
                      child: Text(
                        'Email',
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 160, right: 50),
                      child: TextField(
                        controller: email,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 240),
                      child: Text(
                        'Password',
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 260, right: 50),
                      child: TextFormField(
                        controller: pw,
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
                      padding: const EdgeInsets.only(top: 340, right: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          signup();
                          // Add your button's action here
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
                              'SIGN UP',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
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
                      padding: const EdgeInsets.only(top: 390),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyLogin()));
                            },
                            child: Text(
                              "Log In",
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

  Future authprofilesetting(UserCredential cred, String name) async {
    await cred.user?.updateDisplayName(name);
    // await cred.user?.updatePhoneNumber(contact as PhoneAuthCredential);
    await cred.user?.updatePhotoURL(
        'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2Fdefaultimage.jpg?alt=media&token=af41bdaf-f5f4-4f0d-ad96-78734f8eb73a');
  }

  Future signup() async {
    print(email.text);
    print(pw.text);
    String name = userr.text.trim();
    String emailAddress = email.text.trim();
    String password = pw.text.trim();

    // Validate input if needed
    // final isValid = formkey.currentState!.validate();
    // if (!isValid) return;

    try {
      // Create a new user with email and password
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      // Get the user ID
      // String userId = result.user!.uid;
      User user = FirebaseAuth.instance.currentUser!;
      // Reference to the Firestore document
      final docUser =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);

      // Data to be stored
      final data = {
        'url':
            'https://firebasestorage.googleapis.com/v0/b/pc-builder-2c0a4.appspot.com/o/DisplayPicture%2Fdefaultimage.jpg?alt=media&token=af41bdaf-f5f4-4f0d-ad96-78734f8eb73a',
        'userid': user.uid,
        'Name': name,
        'role': 'user',
        'Email': emailAddress.toLowerCase(),
        'Address': '',
        'pw': password
        // 'Phone': int.parse(_controller.text)
      };

      // Set data in Firestore
      await docUser.set(data);

      // Show success message
      Fluttertoast.showToast(msg: 'Signup Successful!');

      // Navigate to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLogin(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Show error message
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
    } catch (e) {
      // Handle any other exceptions
      Fluttertoast.showToast(msg: 'An error occurred. Please try again.');
    }
  }
}
