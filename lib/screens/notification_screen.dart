import 'package:flutter/material.dart';
import 'package:quickfix/appbar.dart';
import 'package:quickfix/bottom.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}