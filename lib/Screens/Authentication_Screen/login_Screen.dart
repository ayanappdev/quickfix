import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickfix/Screens/Authentication_Screen/forgot_pw_screen.dart';
import 'package:quickfix/Widgets/hiddendrawer_screen.dart';
// import 'package:quickfix/Screens/home_screen.dart';
import 'package:quickfix/Screens/Authentication_Screen/register_page.dart';
import 'package:quickfix/Widgets/bottomNavigation.dart'; // Import RegisterScreen

class LoginScreen extends StatefulWidget {
  final VoidCallback? showRegisterPage;
  const LoginScreen({Key? key,  this.showRegisterPage})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
  try {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // Fetch the user object after successful login
    User? user = userCredential.user;

    if (user != null) {
      String? displayName = user.displayName; // Fetch display name

      // Navigate to HomeScreen or any other screen after login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HiddenDrawer()),
      );

      // Show a message indicating successful login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Handle case where user object is null (should not happen after successful login)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve user information.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    print('Failed to sign in: $e');
    // Handle different sign-in errors here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to sign in: ${e.message}'),
        duration: Duration(seconds: 5),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Image.asset(
                    "assets/images/logo.PNG",
                    height: 300,
                    width: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: const Text(
                    "Welcome To QuickFix",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "you've been missed",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(78, 27, 111, 97),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(78, 27, 111, 97),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage()));
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 58, 142, 232),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () => signIn(context), // Call signIn method
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 27, 111, 97),
                      ),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the registration page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage(
                                    showLoginPage: () {},
                                  )),
                        );
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Color.fromARGB(255, 58, 142, 232),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:quickfix/Screens/forgot_pw_screen.dart';
// import 'package:quickfix/Screens/home_screen.dart'; // Import HomeScreen

// class LoginScreen extends StatefulWidget {
//   final VoidCallback showRegisterPage;
//   const LoginScreen({Key? key, required this.showRegisterPage})
//       : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> signIn(BuildContext context) async {
//     try {
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       // Navigate to HomeScreen if login is successful
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => HomeScreen()), // Navigate to HomeScreen
//       );
//       print('Signed in successfully!');
//       // Show a message indicating successful login
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Signed in successfully!'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     } on FirebaseAuthException catch (e) {
//       print('Failed to sign in: $e');
//       // Handle different sign-in errors here
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to sign in: ${e.message}'),
//           duration: Duration(seconds: 5),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15),
//                   child: Image.asset(
//                     "assets/images/logo.PNG",
//                     height: 300,
//                     width: 300,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5),
//                   child: const Text(
//                     "Welcome To QuickFix",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   "you've been missed",
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 const SizedBox(
//                   height: 60,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 25),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(78, 27, 111, 97),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Email",
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 25),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(78, 27, 111, 97),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 20),
//                       child: TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Password",
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: GestureDetector(
//                     onTap: () => signIn(context), // Call signIn method
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Color.fromARGB(255, 27, 111, 97),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Not a member?",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     GestureDetector(
//                       onTap: widget.showRegisterPage,
//                       child: Text(
//                         "Register Now",
//                         style: TextStyle(
//                           color: Color.fromARGB(255, 58, 232, 203),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 150,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:quickfix/Screens/forgot_pw_screen.dart';

// // class LoginScreen extends StatefulWidget {
// //   final VoidCallback showRegisterPage;
// //   const LoginScreen({super.key, required this.showRegisterPage});

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> {
// //   //text controllers
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   Future signIn() async {
// //     await FirebaseAuth.instance.signInWithEmailAndPassword(
// //         email: _emailController.text.trim(),
// //         password: _passwordController.text.trim());
// //   }

// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: Colors.grey[200],
// //         body: SafeArea(
// //           child: Center(
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 15),
// //                     child: Image.asset(
// //                       "assets/images/logo.PNG",
// //                       height: 300,
// //                       width: 300,
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.only(top: 5),
// //                     child: const Text(
// //                       "Welcome To QuickFix",
// //                       style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 30,
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   const Text(
// //                     "you've been missed",
// //                     style: TextStyle(fontSize: 20),
// //                   ),
// //                   const SizedBox(
// //                     height: 60,
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: 25),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                           color: Color.fromARGB(78, 27, 111, 97),
// //                           borderRadius: BorderRadius.circular(12)),
// //                       child: Padding(
// //                         padding: const EdgeInsets.only(left: 20),
// //                         child: TextField(
// //                           controller: _emailController,
// //                           decoration: InputDecoration(
// //                             border: InputBorder.none,
// //                             hintText: "Email",
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     height: 10,
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: 25),
// //                     child: Container(
// //                       decoration: BoxDecoration(
// //                           color: Color.fromARGB(78, 27, 111, 97),
// //                           borderRadius: BorderRadius.circular(12)),
// //                       child: Padding(
// //                         padding: const EdgeInsets.only(left: 20),
// //                         child: TextField(
// //                           controller: _passwordController,
// //                           obscureText: true,
// //                           decoration: const InputDecoration(
// //                             border: InputBorder.none,
// //                             hintText: "Password",
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         GestureDetector(
// //                           onTap: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(builder: (context) {
// //                                 return ForgotPasswordPage();
// //                               }),
// //                             );
// //                           },
// //                           child: Text(
// //                             "Forgot Password?",
// //                             style: TextStyle(
// //                               color: Color.fromARGB(255, 58, 232, 203),
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(
// //                     height: 10,
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 25.0),
// //                     child: GestureDetector(
// //                       onTap: signIn,
// //                       child: Container(
// //                         padding: EdgeInsets.all(20),
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(12),
// //                           color: Color.fromARGB(255, 27, 111, 97),
// //                         ),
// //                         child: Center(
// //                           child: Text(
// //                             "Sign In",
// //                             style: TextStyle(
// //                               color: Colors.white,
// //                               fontSize: 18,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(
// //                     height: 25,
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       const Text(
// //                         "Not a member?",
// //                         style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         width: 5,
// //                       ),
// //                       GestureDetector(
// //                         onTap: widget.showRegisterPage,
// //                         child: Text(
// //                           "Register Now",
// //                           style: TextStyle(
// //                             color: Color.fromARGB(255, 58, 232, 203),
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(
// //                     height: 150,
// //                   )
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ));
// //   }
// // }
