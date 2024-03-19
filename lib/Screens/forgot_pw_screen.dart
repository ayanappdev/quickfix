import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 27, 111, 97),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email and we will send you a password reset link",
              textAlign: TextAlign.center,
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
          MaterialButton(
            onPressed: () {},
            child: Text("Reset Password"),
            color: Color.fromARGB(105, 27, 111, 97),
          )
        ],
      ),
    );
  }
}
