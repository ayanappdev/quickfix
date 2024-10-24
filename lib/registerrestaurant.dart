import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickfix/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegisterRestaurantScreen extends StatefulWidget {
  @override
  _RegisterRestaurantScreenState createState() =>
      _RegisterRestaurantScreenState();
}

class _RegisterRestaurantScreenState extends State<RegisterRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _resnamecontroller = TextEditingController();
  final TextEditingController _resdesccontroller = TextEditingController();
  final TextEditingController _locationcontroller = TextEditingController();
  final TextEditingController _banknamecontroller = TextEditingController();
  final TextEditingController _accnumcontroller = TextEditingController();
  final TextEditingController _tablescontroller = TextEditingController();

  @override
  void dispose() {
    _resnamecontroller.dispose();
    _resdesccontroller.dispose();
    _locationcontroller.dispose();
    _banknamecontroller.dispose();
    _accnumcontroller.dispose();
    _tablescontroller.dispose();
    super.dispose();
  }

  // Variables for storing input values
  File? profileImage;
  TimeOfDay? openingTime;
  TimeOfDay? closingTime;
  List<String> selectedCuisines = [];
  List<File> menuImages = [];
  String numberOfTables = ''; // Field for the number of tables

  final List<String> cuisineOptions = [
    'Desi',
    'Chinese',
    'Fast Food',
    'Pizza',
    'Burger',
    'Coffee',
    'Dessert',
    'Pasta'
  ];

  final ImagePicker _picker = ImagePicker();

  // Function to pick profile image
  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to pick menu images
  Future<void> _pickMenuImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        menuImages = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // Function to save restaurant data to Firebase
  Future<void> _saveRestaurantData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await FirebaseFirestore.instance.collection('restaurants').add({
          'name': _resnamecontroller.text,
          'description': _resdesccontroller.text,
          'location': _locationcontroller.text,
          'opening_time': openingTime!.format(context),
          'closing_time': closingTime!.format(context),
          'cuisines': selectedCuisines,
          'tables': int.parse(_tablescontroller.text),
          'bank_name': _banknamecontroller.text,
          'account_number': _accnumcontroller.text,
          'menu_images':
              [], // Handle image upload to Firebase Storage separately
          'profile_image':
              '', // Handle profile image upload to Firebase Storage separately
          'created_by': FirebaseAuth.instance.currentUser!.uid,
        });
        Fluttertoast.showToast(msg: "Restaurant registered successfully!");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        Fluttertoast.showToast(msg: "Error: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Restaurant',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Baskerville',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFFFDD301),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Logout') {
                // Implement your logout logic here
                logout(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Restaurant Name
                _buildTextInput("Restaurant Name", _resnamecontroller),
                SizedBox(height: 10),
                // Restaurant Description
                _buildTextInput("Restaurant Description", _resdesccontroller),
                SizedBox(height: 20),
                // Profile Image Upload Button
                _buildImagePicker("Upload Restaurant Profile",
                    _pickProfileImage, profileImage),
                SizedBox(height: 20),
                // Timings
                _buildTimePickers(),
                SizedBox(height: 15),
                // MultiSelectFormField for Cuisine Type
                _buildCuisineSelector(),
                SizedBox(height: 15),
                // Restaurant Location
                _buildTextInput("Restaurant Location", _locationcontroller),
                SizedBox(height: 20),
                // Upload Menu Pictures Button
                _buildMenuImagePicker(),
                SizedBox(height: 10),
                // Number of Tables
                _buildTextInput("Total Tables", _tablescontroller,
                    keyboardType: TextInputType.number),
                SizedBox(height: 10),
                // Bank Name and Account Number
                _buildTextInput("Bank Name", _banknamecontroller),
                _buildTextInput("Account Number", _accnumcontroller,
                    keyboardType: TextInputType.number),
                SizedBox(height: 50),
                // Register Restaurant Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFDD301),
                    foregroundColor: Colors.black, // Button text color
                  ),
                  onPressed: _saveRestaurantData,
                  child: Text('Register Restaurant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: label,
          ),
          style: TextStyle(color: Colors.black),
          keyboardType: keyboardType,
          validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
        ),
      ],
    );
  }

  Widget _buildImagePicker(String label, Function pickImage, File? imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(height: 5),
        ElevatedButton(
          onPressed: () => pickImage(),
          child: Text(label),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Color(0xFFFDD301), // Text color
          ),
        ),
        SizedBox(height: 10),
        imageFile != null
            ? Image.file(imageFile, width: 50, height: 50, fit: BoxFit.cover)
            : Container(),
      ],
    );
  }

  Widget _buildTimePickers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTimePicker("Opening Time", (pickedTime) {
          setState(() {
            openingTime = pickedTime;
          });
        }, openingTime),
        _buildTimePicker("Closing Time", (pickedTime) {
          setState(() {
            closingTime = pickedTime;
          });
        }, closingTime),
      ],
    );
  }

  Widget _buildTimePicker(
      String label, Function onTimePicked, TimeOfDay? selectedTime) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) onTimePicked(pickedTime);
            },
            child: Text(
                selectedTime != null ? selectedTime.format(context) : "Select"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFDD301),
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineSelector() {
    return MultiSelectDialogField(
      items: cuisineOptions
          .map((cuisine) => MultiSelectItem(cuisine, cuisine))
          .toList(),
      title: Text("Select Cuisines", style: TextStyle(color: Colors.black)),
      selectedColor: Color(0xFFFDD301),
      buttonText: Text(
        "Select Cuisine Types",
        style: TextStyle(color: Colors.white),
      ),
      onConfirm: (results) {
        setState(() {
          selectedCuisines = results.cast<String>();
        });
      },
    );
  }

  Widget _buildMenuImagePicker() {
    return _buildImagePicker("Upload Menu Pictures", _pickMenuImages, null);
  }

  void logout(BuildContext context) {
    // Implement the logout functionality here
  }
}
