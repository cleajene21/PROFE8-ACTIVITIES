import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_view.dart';
import 'rental_form_view.dart';
import 'rentals_view.dart';
import 'profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  int _camerasViewedCounter = 0;
  final GlobalKey<RentalsViewState> _rentalsViewKey =
      GlobalKey<RentalsViewState>();

  void _incrementCounter() {
    setState(() {
      _camerasViewedCounter++;
    });
  }

  Future<void> _navigateToRentalForm(String cameraId) async {
    final bool? result = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => RentalFormView(cameraId: cameraId),
      ),
    );

    if (result == true) {
      _rentalsViewKey.currentState?.refreshRentals();
      setState(() {
        _currentIndex = 1; // Switch to My Rentals tab
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('CameraRent Pro'),
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          actions: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  'Viewed: $_camerasViewedCounter',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeView(
              onCameraViewed: _incrementCounter,
              onRentCamera: _navigateToRentalForm,
            ),
            RentalsView(key: _rentalsViewKey),
            const ProfileView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if (index == 1) {
              _rentalsViewKey.currentState?.refreshRentals();
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue[600],
          unselectedItemColor: Colors.grey[600],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.list_bullet),
              label: 'My Rentals',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'Profile',
            ),
          ],
        ),
      );
}
