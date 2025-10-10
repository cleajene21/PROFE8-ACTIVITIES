import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    const lightPink = Color(0xFFF8BBD0);

    return Scaffold(
      backgroundColor: lightPink,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: pinkAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              width: double.infinity,
              child: const Center(
                child: Text(
                  'My Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: pinkAccent, size: 45),
            ),
            const SizedBox(height: 10),
            const Text(
              'Guest User',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: pinkAccent,
              ),
            ),
            const Text('guest@example.com',
                style: TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Account Information',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: pinkAccent)),
                    SizedBox(height: 8),
                    _InfoRow(Icons.phone, 'Contact Number', '+63 912 345 6789'),
                    _InfoRow(Icons.location_on, 'Address',
                        'Talisay City, Negros Occidental'),
                    _InfoRow(
                        Icons.calendar_today, 'Member Since', 'March 2025'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(backgroundColor: pinkAccent),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                  icon: const Icon(Icons.info_outline),
                  label: const Text('About App'),
                  style: ElevatedButton.styleFrom(backgroundColor: pinkAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent),
          const SizedBox(width: 8),
          Expanded(child: Text('$label: $value')),
        ],
      ),
    );
  }
}
