import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Email validation regex
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Validation and Snackbar logic
  void _validateAndLogin(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validate email and password
    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Please fill in all fields.");
    } else if (!emailRegex.hasMatch(email)) {
      _showSnackbar(context, "Please enter a valid email address.");
    } else {
      // If validation passes, navigate to the dashboard
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DashboardScreen(
                userRole: 'Admin' == 'Admin' ? 'Beneficiary' : 'Agent')),
      );
    }
  }

  // Helper method to show Snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 212, 237),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 198, 212, 237),
        title: const Text('Login to the Social Security System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _validateAndLogin(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
