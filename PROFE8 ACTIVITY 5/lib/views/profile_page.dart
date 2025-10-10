import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const pinkAccent = Color(0xFFE91E63);
    const lightPink = Color(0xFFF8BBD0);
    const darkPink = Color(0xFFC2185B);

    return Scaffold(
      backgroundColor: lightPink,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: pinkAccent,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: pinkAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Enhanced Profile Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: pinkAccent.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Profile Image with Decoration
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [pinkAccent, darkPink],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: pinkAccent.withOpacity(0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            // Online Status Indicator
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // User Name with Custom Styling
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Guest User',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: pinkAccent,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Email with Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'guest@example.com',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Stats Row
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey[200]!,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _StatItem(
                                value: '12',
                                label: 'Bookings',
                                icon: Icons.calendar_today,
                                color: pinkAccent,
                              ),
                              _StatItem(
                                value: '4.8',
                                label: 'Rating',
                                icon: Icons.star,
                                color: Colors.amber,
                              ),
                              _StatItem(
                                value: '2',
                                label: 'Years',
                                icon: Icons.workspace_premium,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Enhanced Account Information Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section Header
                        Row(
                          children: const [
                            Icon(
                              Icons.account_circle,
                              color: pinkAccent,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Account Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: pinkAccent,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Information Rows
                        _EnhancedInfoRow(
                          icon: Icons.phone_iphone_rounded,
                          label: 'Contact Number',
                          value: '+63 912 345 6789',
                          iconColor: Colors.green,
                          onTap: () {},
                        ),
                        _EnhancedInfoRow(
                          icon: Icons.location_pin,
                          label: 'Address',
                          value: 'Talisay City, Negros Occidental',
                          iconColor: Colors.blue,
                          onTap: () {},
                        ),
                        _EnhancedInfoRow(
                          icon: Icons.cake_rounded,
                          label: 'Birthday',
                          value: 'January 15, 1990',
                          iconColor: Colors.orange,
                          onTap: () {},
                        ),
                        _EnhancedInfoRow(
                          icon: Icons.calendar_today_rounded,
                          label: 'Member Since',
                          value: 'March 2025',
                          iconColor: pinkAccent,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.edit_note_rounded,
                        text: 'Edit Profile',
                        color: pinkAccent,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionButton(
                        icon: Icons.settings_rounded,
                        text: 'Settings',
                        color: darkPink,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Additional Action Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _ActionButton(
                  icon: Icons.info_outline_rounded,
                  text: 'About App',
                  color: Colors.purple,
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Enhanced Info Row Component
class _EnhancedInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final VoidCallback onTap;

  const _EnhancedInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey[400],
        ),
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(vertical: -2),
      ),
    );
  }
}

// Stat Item Component
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Action Button Component
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        shadowColor: color.withOpacity(0.3),
      ),
    );
  }
}
