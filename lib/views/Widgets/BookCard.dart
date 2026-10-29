import 'package:flutter/material.dart';
import '../../models/book.dart';

class BookCard extends StatelessWidget {
  final BookGroup bookGroup;
  final VoidCallback onBorrowPressed;

  const BookCard({Key? key, required this.bookGroup, required this.onBorrowPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAvailable = bookGroup.availableQuantity > 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(bookGroup.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          'Penulis: ${bookGroup.author}\n'
          'Total Stok: ${bookGroup.totalQuantity} | Tersedia: ${bookGroup.availableQuantity}',
        ),
        isThreeLine: true,
        trailing: ElevatedButton(
          onPressed: isAvailable ? onBorrowPressed : null,
          child: Text(isAvailable ? 'Pinjam' : 'Habis'),
        ),
      ),
    );
  }
}