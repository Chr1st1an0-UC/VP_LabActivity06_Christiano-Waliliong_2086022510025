import 'package:flutter/material.dart';
import '../../models/loan.dart';

class LoanCard extends StatelessWidget {
  final Loan loan;
  final String statusText;
  final VoidCallback onReturnPressed;

  const LoanCard({
    Key? key, 
    required this.loan, 
    required this.statusText, 
    required this.onReturnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('ID Pinjam: ${loan.loanId}'),
        subtitle: Text('Buku ID: ${loan.bookId}\nStatus: $statusText\nDue Date: ${loan.dueDate.toLocal().toString().split(' ')[0]}'),
        isThreeLine: true,
        trailing: loan.isActive
            ? ElevatedButton(
                onPressed: onReturnPressed,
                child: const Text('Kembalikan'),
              )
            : const Text('Selesai', style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}