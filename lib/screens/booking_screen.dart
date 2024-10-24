import 'package:flutter/material.dart';
import 'package:quickfix/appbar.dart';
import 'package:quickfix/bottom.dart';


class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}