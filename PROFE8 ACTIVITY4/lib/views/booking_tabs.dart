import 'package:flutter/material.dart';

class BookingTabs extends StatelessWidget {
  const BookingTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Information'),
          backgroundColor: Colors.pinkAccent,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Current'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Your current bookings')),
            Center(child: Text('Your booking history')),
          ],
        ),
      ),
    );
  }
}
