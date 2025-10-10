import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import 'login_view.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();

  String _selectedRole = 'User'; // Default role
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final success = await _authService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

      setState(() => _isLoading = false);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Registration successful! Please log in.')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed. Try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color pinkAccent = Color(0xFFE91E63); // Main pink
    const Color lightPink = Color(0xFFF8BBD0); // Light pink background
    const Color white = Colors.white;

    return Scaffold(
      backgroundColor: lightPink,
      appBar: AppBar(
        title: const Text(
          'Register Account',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              CustomTextField(
                controller: _nameController,
                labelText: 'Full Name',
                prefixIcon: Icons.person,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Confirm Password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: InputDecoration(
                  labelText: 'Select Role',
                  prefixIcon:
                      const Icon(Icons.person_outline, color: pinkAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: pinkAccent),
                  ),
                  filled: true,
                  fillColor: white,
                ),
                dropdownColor: white,
                iconEnabledColor: pinkAccent,
                items: const [
                  DropdownMenuItem(value: 'User', child: Text('User')),
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Register',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: pinkAccent,
                    fontWeight: FontWeight.bold,
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
