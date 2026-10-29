import 'package:flutter/material.dart';

class FineSummaryCard extends StatelessWidget {
  final double amount;
  final String statusText;

  const FineSummaryCard({Key? key, required this.amount, required this.statusText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber[50],
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Status Pengembalian: $statusText', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Total Denda / Tagihan: Rp ${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}