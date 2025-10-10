import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Welcome to Haircut Booking App!\n\n'
            'This app allows customers to conveniently book haircut services, '
            'choose barbers, and manage their appointments with ease.\n\n'
            'Developed as part of Activity 4 - Navigation.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
