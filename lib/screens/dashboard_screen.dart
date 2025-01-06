import 'package:flutter/material.dart';
import 'wallet_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulating user role for demonstration
    String userRole = 'Beneficiary'; // Replace with dynamic role retrieval

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 212, 237),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 198, 212, 237),
        title: Text('$userRole Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adding the uploaded image
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Optional rounded corners
              child: Image.asset(
                'assets/images/beneficiary_page.png', // Path to your uploaded image
                height: 200, // Adjust height as needed
                width: 200, // Adjust width as needed
                fit: BoxFit.cover, // Adjust the image's fit
              ),
            ),
            const SizedBox(height: 20), // Space between image and text
            Text('Welcome, $userRole!', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Wallet Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WalletScreen(role: userRole)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Go to Wallet',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
