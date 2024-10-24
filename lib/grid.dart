import 'package:flutter/material.dart';
import 'booking.dart';


class GridScreen extends StatefulWidget {
  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  List<bool> _isTableBooked = List.generate(20, (index) => false);
  List<String> _notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Table'),
        backgroundColor: Color(0xFFFDD301),
        foregroundColor: Colors.black,

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIndicator(Colors.green, "Available tables"),
                SizedBox(width: 20),
                _buildIndicator(Colors.red, "Booked tables"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 19,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (_isTableBooked[index]) {
                        _showAlreadyBookedMessage(context);
                      } else {
                        final isBooked = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingScreen()),
                        );

                        if (isBooked == true) {
                          setState(() {
                            _isTableBooked[index] = true;
                            _notifications.add('Table ${index + 1} has been booked.');
                          });
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isTableBooked[index] ? Colors.red : Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _isTableBooked[index] ? Icons.event_busy : Icons.event_seat,
                              color: Colors.white,
                              size: 48.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Table ${(index + 1)}',
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAlreadyBookedMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Table Booked'),
          content: Text('This table is already booked. Kindly look for other tables.'),
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
  }

  Widget _buildIndicator(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
