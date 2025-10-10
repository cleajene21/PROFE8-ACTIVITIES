import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/about_page.dart';
import 'views/contact_page.dart';
import 'views/drawer_bottom_nav.dart';

void main() {
  runApp(const HaircutBookingApp());
}

class HaircutBookingApp extends StatelessWidget {
  const HaircutBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haircut Booking Form',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginView(),
        '/home': (context) => const DrawerBottomNav(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
