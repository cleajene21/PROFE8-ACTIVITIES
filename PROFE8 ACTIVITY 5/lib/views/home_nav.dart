import 'package:flutter/material.dart';
import 'booking_view.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BookingView is a full screen (Scaffold) from your Activity 3 code.
    // We return it directly so the Home tab shows the booking form / list.
    return const BookingView();
  }
}
