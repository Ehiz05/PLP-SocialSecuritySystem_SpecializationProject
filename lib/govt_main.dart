import 'package:flutter/material.dart';

class GovtMainScreen extends StatelessWidget {
  const GovtMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Government Agent Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to manage service requests
              },
              child: const Text("Manage Service Requests"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to assist users
              },
              child: const Text("Assist Users"),
            ),
          ],
        ),
      ),
    );
  }
}
