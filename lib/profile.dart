import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickfix/login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user =
      FirebaseAuth.instance.currentUser; // Get the currently logged-in user
  String? userName;
  String? userEmail;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchUserProfile(); // Fetch user profile details if logged in
    }
  }

  // Function to fetch user profile details from Firestore
  Future<void> _fetchUserProfile() async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      setState(() {
        userName = userData['name'];
        userEmail = userData['email'];
        profileImageUrl = userData[
            'profileImageUrl']; // Assuming profileImageUrl is stored in Firestore
      });
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Baskerville',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFDD301),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: user != null ? _buildUserProfile() : _buildGuestView(),
        ),
      ),
    );
  }

  // Widget to build the user profile view
  Widget _buildUserProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (profileImageUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileImageUrl!),
          )
        else
          CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
        SizedBox(height: 20),
        Text(
          userName ?? 'User Name',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          userEmail ?? 'User Email',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFDD301),
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            setState(() {
              user = null; // Reset user data on logout
            });
          },
          child: Text('Logout'),
        ),
      ],
    );
  }

  // Widget to build the guest view
  Widget _buildGuestView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.person_outline, size: 100, color: Colors.white),
        SizedBox(height: 20),
        Text(
          'Guest User',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        SizedBox(height: 10),
        Text(
          'Please log in to view your profile.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFDD301),
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyLogin()));
          },
          child: Text('Login'),
        ),
      ],
    );
  }
}
