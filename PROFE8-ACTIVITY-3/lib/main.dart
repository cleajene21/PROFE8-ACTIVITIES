import 'package:flutter/material.dart';
import 'views/login_view.dart';

void main() {
  runApp(const HaircutBookingApp());
}

class HaircutBookingApp extends StatelessWidget {
  const HaircutBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haircut Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
