import 'package:flutter/material.dart';
import 'wallet_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String userRole;

  const DashboardScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 212, 237),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 198, 212, 237),
        title: Text('$userRole Dashboard'),
      ),
      body: _buildRoleSpecificContent(context),
    );
  }

  Widget _buildRoleSpecificContent(BuildContext context) {
    switch (userRole) {
      case 'Admin':
        return _buildAdminDashboard(context);
      case 'Agent':
        return _buildAgentDashboard(context);
      case 'Beneficiary':
        return _buildBeneficiaryDashboard(context);
      default:
        return const Center(
          child: Text(
            'Unknown Role',
            style: TextStyle(fontSize: 20),
          ),
        );
    }
  }

  // Admin Dashboard
  Widget _buildAdminDashboard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Admin-specific image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/AdminSSA.png', // Replace with actual image path
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome, Admin!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showMessage(context, 'Managing Users...');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Manage Users',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
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
    );
  }

  // Government Agent Dashboard
  Widget _buildAgentDashboard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Government Agent-specific image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/govSSA.png', // Replace with actual image path
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome, Government Agent!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showMessage(context, 'Verifying Beneficiaries...');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Verify Beneficiaries',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
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
    );
  }

  // Beneficiary Dashboard
  Widget _buildBeneficiaryDashboard(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Beneficiary-specific image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/beneficiary_page.png', // Replace with actual image path
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome, Beneficiary!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _showMessage(context, 'Checking Payments...');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text(
              'Check Payments',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
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
    );
  }

  // Helper function to show a snackbar message
  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
