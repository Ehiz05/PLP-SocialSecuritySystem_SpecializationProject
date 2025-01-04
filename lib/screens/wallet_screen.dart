import 'package:flutter/material.dart';
import '../widgets/wallet_balance_card.dart';
import '../widgets/wallet_transaction_list.dart';

class WalletScreen extends StatelessWidget {
  final String role;

  const WalletScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('$role Wallet',
            style: const TextStyle(color: Colors.white, fontSize: 22)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const WalletBalanceCard(balance: 56919.95),
            const SizedBox(height: 20),
            if (role == 'Admin' || role == 'Agent')
              ElevatedButton(
                onPressed: () {
                  // Navigate to payment management screen
                },
                child: const Text('Manage Payments'),
              ),
            if (role == 'Beneficiary')
              ElevatedButton(
                onPressed: () {
                  // Navigate to receive payment screen
                },
                child: const Text('Request Payment'),
              ),
            const SizedBox(height: 20),
            Expanded(child: WalletTransactionList(role: role)),
          ],
        ),
      ),
    );
  }
}
