import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

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
            // Back button added here
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: _Header(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const _ContactCard(),
            const SizedBox(height: 16),
            const _SocialRow(),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                '© 2025 Haircut Booking App — KB’s StopOver',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    return Container(
      color: pinkAccent,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Center(
        child: Text(
          'Contact Us',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: Text(
                'We’d love to hear from you!',
                style: TextStyle(
                    color: pinkAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            _ContactInfo(Icons.location_on, 'Visit Us',
                'KB’s StopOver, Talisay City, Negros Occidental'),
            _ContactInfo(
                Icons.phone, 'Call Us', '(034) 123-4567 / +63 900 123 4567'),
            _ContactInfo(Icons.email, 'Email', 'support@haircutbooking.com'),
            _ContactInfo(Icons.access_time, 'Business Hours',
                'Mon–Sat: 9:00 AM – 8:00 PM'),
          ],
        ),
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactInfo(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.pinkAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$title: $value',
                style: const TextStyle(color: Colors.black87, height: 1.3)),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  const _SocialRow();

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook, color: pinkAccent),
        SizedBox(width: 10),
        Icon(Icons.camera_alt, color: pinkAccent),
        SizedBox(width: 10),
        Icon(Icons.language, color: pinkAccent),
      ],
    );
  }
}
