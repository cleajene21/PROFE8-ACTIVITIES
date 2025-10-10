import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool autoBookingReminders = true;

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    const lightPink = Color(0xFFF8BBD0);

    return Scaffold(
      backgroundColor: lightPink,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              color: pinkAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    activeColor: pinkAccent,
                    title: const Text('Enable Notifications'),
                    value: notificationsEnabled,
                    onChanged: (value) =>
                        setState(() => notificationsEnabled = value),
                  ),
                  SwitchListTile(
                    activeColor: pinkAccent,
                    title: const Text('Auto Booking Reminders'),
                    value: autoBookingReminders,
                    onChanged: (value) =>
                        setState(() => autoBookingReminders = value),
                  ),
                  SwitchListTile(
                    activeColor: pinkAccent,
                    title: const Text('Dark Mode'),
                    value: darkMode,
                    onChanged: (value) => setState(() => darkMode = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline, color: pinkAccent),
                    title: const Text('Change Password'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: pinkAccent),
                    title: const Text('Logout'),
                    onTap: () => Navigator.pushReplacementNamed(context, '/'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                '© 2025 Haircut Booking App',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
