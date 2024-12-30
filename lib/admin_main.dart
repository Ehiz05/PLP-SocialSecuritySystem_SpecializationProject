import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to manage agents
              },
              child: const Text("Manage Government Agents"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to manage users
              },
              child: const Text("Manage Users"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to view reports
              },
              child: const Text("View Reports"),
            ),
          ],
        ),
      ),
    );
  }
}
