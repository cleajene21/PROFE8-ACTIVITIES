import 'package:flutter/material.dart';
import 'home_nav.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'about_page.dart';
import 'contact_page.dart';
import 'communication_tabs.dart';

class DrawerBottomNav extends StatefulWidget {
  const DrawerBottomNav({Key? key}) : super(key: key);

  @override
  State<DrawerBottomNav> createState() => _DrawerBottomNavState();
}

class _DrawerBottomNavState extends State<DrawerBottomNav> {
  int _selectedIndex = 0;

  // ✅ Fixed: removed const list literal issue
  final List<Widget> _screens = [
    const HomeNav(),
    const ProfilePage(),
    const SettingsPage(),
    const AboutPage(),
    const ContactPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Drawer item helper
  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.pinkAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color pinkAccent = Color(0xFFE91E63);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Haircut Booking Home'),
        backgroundColor: pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: pinkAccent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.content_cut, size: 50, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Haircut Booking Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Drawer Items
            _drawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            _drawerItem(
              icon: Icons.person,
              title: 'Profile',
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 1);
              },
            ),
            _drawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 2);
              },
            ),
            const Divider(),
            _drawerItem(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 3);
              },
            ),
            _drawerItem(
              icon: Icons.contact_mail_outlined,
              title: 'Contact',
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 4);
              },
            ),
            _drawerItem(
              icon: Icons.chat,
              title: 'Barber Chat Center',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CommunicationTabs()),
                );
              },
            ),
          ],
        ),
      ),

      // ✅ Body: shows embedded pages
      body: _screens[_selectedIndex],

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 2 ? 0 : _selectedIndex,
        onTap: (index) {
          if (index <= 2) {
            _onItemTapped(index);
          }
        },
        selectedItemColor: pinkAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
