import 'package:flutter/material.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Summary'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back to Booking Form'),
        ),
      ),
    );
  }
}
