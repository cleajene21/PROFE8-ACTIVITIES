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

  // Theme data for light mode
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFFE91E63),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE91E63),
      secondary: Color(0xFFF8BBD0),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8BBD0),
    cardColor: Colors.white,
  );

  // Theme data for dark mode
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFE91E63),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFE91E63),
      secondary: Color(0xFF880E4F),
      surface: Color(0xFF121212),
      background: Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
  );

  void _toggleDarkMode(bool value) {
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = darkMode ? _darkTheme : _lightTheme;
    const pinkAccent = Color(0xFFE91E63);

    return Theme(
      data: currentTheme,
      child: Scaffold(
        backgroundColor: currentTheme.scaffoldBackgroundColor,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: currentTheme.cardColor,
                elevation: 2,
                child: Column(
                  children: [
                    SwitchListTile(
                      activeColor: pinkAccent,
                      title: Text(
                        'Enable Notifications',
                        style: TextStyle(
                          color: currentTheme.colorScheme.onSurface,
                        ),
                      ),
                      value: notificationsEnabled,
                      onChanged: (value) =>
                          setState(() => notificationsEnabled = value),
                    ),
                    SwitchListTile(
                      activeColor: pinkAccent,
                      title: Text(
                        'Auto Booking Reminders',
                        style: TextStyle(
                          color: currentTheme.colorScheme.onSurface,
                        ),
                      ),
                      value: autoBookingReminders,
                      onChanged: (value) =>
                          setState(() => autoBookingReminders = value),
                    ),
                    SwitchListTile(
                      activeColor: pinkAccent,
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: currentTheme.colorScheme.onSurface,
                        ),
                      ),
                      value: darkMode,
                      onChanged: _toggleDarkMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: currentTheme.cardColor,
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.lock_outline, color: pinkAccent),
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: currentTheme.colorScheme.onSurface,
                        ),
                      ),
                      onTap: () {
                        // Add change password functionality
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: pinkAccent),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: currentTheme.colorScheme.onSurface,
                        ),
                      ),
                      onTap: () => Navigator.pushReplacementNamed(context, '/'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '© 2025 Haircut Booking App',
                  style: TextStyle(
                    color: darkMode ? Colors.grey : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
