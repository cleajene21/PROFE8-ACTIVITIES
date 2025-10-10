import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/login_view.dart';
import 'views/about_page.dart';
import 'views/contact_page.dart';
import 'views/drawer_bottom_nav.dart';

import 'providers/theme_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // Task 4
        ChangeNotifierProvider(create: (_) => CartProvider()), // Task 1,2,3
        ChangeNotifierProvider(create: (_) => TodoProvider()), // Task 5
      ],
      child: const HaircutBookingApp(),
    ),
  );
}

class HaircutBookingApp extends StatelessWidget {
  const HaircutBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Watch theme provider to rebuild MaterialApp when theme changes
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haircut Booking',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFF8BBD0),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
      ),
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
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
