import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedRole; // To store the selected role

  // Email validation regex
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // Validation and Snackbar logic
  void _validateAndRegister(BuildContext context) {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Validate inputs
    if (name.isEmpty) {
      _showSnackbar(context, "Full Name is required.");
    } else if (email.isEmpty) {
      _showSnackbar(context, "Email is required.");
    } else if (!emailRegex.hasMatch(email)) {
      _showSnackbar(context, "Please enter a valid email address.");
    } else if (password.isEmpty) {
      _showSnackbar(context, "Password is required.");
    } else if (password.length < 6) {
      _showSnackbar(context, "Password must be at least 6 characters long.");
    } else if (_selectedRole == null) {
      _showSnackbar(context, "Please select a role.");
    } else {
      // If all validations pass, navigate to the dashboard
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const DashboardScreen(
                userRole: 'Admin' == 'Admin' ? 'Agent' : 'Beneficiary')),
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
      appBar: AppBar(
        title: const Text('Register for Sunepa Social Security Hub'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: _selectedRole,
                items: const [
                  DropdownMenuItem(value: 'Admin', child: Text('Admin')),
                  DropdownMenuItem(
                      value: 'Agent', child: Text('Government Agent')),
                  DropdownMenuItem(
                      value: 'Beneficiary', child: Text('Beneficiary')),
                ],
                decoration: const InputDecoration(labelText: 'Role'),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _validateAndRegister(context),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
