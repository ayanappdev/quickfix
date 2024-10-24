import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Make sure this is properly imported

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _numberOfPeople;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFDD301),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.8), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _selectDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: _selectedDate == null
                            ? ''
                            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFDD301),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Select a date',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 05),
                Text(
                  "Booking can only be made on today's date!",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Choose Time',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: _selectTime,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: _selectedTime == null
                            ? ''
                            : _selectedTime!.format(context),
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFDD301),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Select time',
                        hintStyle: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Number of People',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: _numberOfPeople,
                  onChanged: (value) {
                    setState(() {
                      _numberOfPeople = value;
                    });
                  },
                  items: List.generate(10, (index) => index + 1)
                      .map((num) => DropdownMenuItem<int>(
                            value: num,
                            child: Text('$num'),
                          ))
                      .toList(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFDD301),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Text('Select number of people'),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(height: 8),
                SizedBox(height: 50),
                Center(
                  child: ElevatedButton(
                    onPressed: _bookTable,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFFDD301), // Button text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize:
                          Size(double.infinity, 60), // Increased height
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    child: Text('Book', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now,
    );
    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  Future<void> _selectTime() async {
    final now = TimeOfDay.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? now,
    );
    if (selectedTime != null && selectedTime != _selectedTime) {
      final nowDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        now.hour,
        now.minute,
      );
      final selectedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(nowDateTime)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Enter time ahead of the current time'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else if (selectedTime.hour < 12 || selectedTime.hour > 23) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Enter time between 12:00 PM and 12:00 AM'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          _selectedTime = selectedTime;
        });
      }
    }
  }

  void _bookTable() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null ||
          _selectedTime == null ||
          _numberOfPeople == null) {
        _showDialog('Error', "Please provide all the details");
      } else if (_numberOfPeople == null) {
        _showDialog('Error', 'Please select number of People');
      } else if (_selectedDate == null) {
        _showDialog('Error', "Please select today's date");
      } else if (_selectedTime == null) {
        _showDialog('Error', "Please select time slot for your booking");
      } else {
        _showDialog('Success', 'Your table has been booked successfully',
            isSuccess: true);
      }
    }
  }

  void _showDialog(String title, String content, {bool isSuccess = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.of(context)
                      .pop(true); // Return true to indicate success
                }
              },
            ),
          ],
        );
      },
    );
  }
}
