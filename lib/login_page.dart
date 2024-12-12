import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse("http://localhost:5000/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', data['user']['id']);
      prefs.setString('role', data['user']['role']);
      prefs.setString('name', data['user']['name']);

      switch (data['user']['role']) {
        case 'admin':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AdminDashboard()));
          break;
        case 'government_agent':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AgentDashboard()));
          break;
        case 'user':
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserDashboard()));
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Unknown role, contact admin!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials!")),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login", style: TextStyle(fontSize: 24)),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: loginUser,
                      child: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
