import 'package:flutter/material.dart';

class WalletTransactionList extends StatelessWidget {
  final String role;

  const WalletTransactionList({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {'amount': 150.0, 'date': '2025-01-01', 'purpose': 'Monthly Benefit'},
      {'amount': 200.0, 'date': '2025-01-02', 'purpose': 'Medical Assistance'},
    ];

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              '\$${transaction['amount']}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            subtitle: Text(
              '${transaction['purpose']} - ${transaction['date']}',
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        );
      },
    );
  }
}
