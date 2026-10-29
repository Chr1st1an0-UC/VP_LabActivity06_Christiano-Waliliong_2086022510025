import 'dart:convert';
import 'package:flutter/services.dart'; // Wajib untuk rootBundle
import '../repositories/book_repo.dart';
import '../repositories/loan_repo.dart';
import '../book.dart';
import '../loan.dart';
import 'fine_policy_service.dart';

class BookService {
  final BookRepository bookRepo;
  final LoanRepository loanRepo;

  // Menggunakan konstanta asset yang Anda tentukan
  static const String assetBuku = 'books.json';

  BookService({required this.bookRepo, required this.loanRepo});

  Future<void> loadAndInitializeBooks() async {
    try {
      // Memanggil data JSON menggunakan konstanta path asset
      final String response = await rootBundle.loadString(assetBuku);
      final List<dynamic> data = json.decode(response);
      
      List<Book> parsedBooks = [];
      int counter = 1;

      for (var item in data) {
        int copies = item['copies'] ?? 1;
        for (int i = 1; i <= copies; i++) {
          String uniqueId = 'B${counter.toString().padLeft(3, '0')}_$i';
          parsedBooks.add(Book.fromJson(item, uniqueId, BookStatus.available));
        }
        counter++;
      }
      
      bookRepo.setBooks(parsedBooks);
    } catch (e) {
      print('Gagal memuat file dari $assetBuku: $e');
    }
  }

  bool borrowBook(String bookId, String studentId) {
    final book = bookRepo.getBookById(bookId);
    if (book == null || book.status != BookStatus.available) {
      return false;
    }

    bool hasActiveLoan = loanRepo.getAllLoans().any((l) => l.bookId == bookId && l.isActive);
    if (hasActiveLoan) return false;

    bookRepo.updateBookStatus(bookId, BookStatus.borrowed);

    final newLoan = Loan(
      loanId: 'L_${DateTime.now().millisecondsSinceEpoch}_$bookId',
      bookId: bookId,
      studentId: studentId,
      borrowingDate: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 14)),
    );

    loanRepo.addLoan(newLoan);
    return true;
  }

  double returnBook(String loanId) {
    final loan = loanRepo.getLoanById(loanId);
    if (loan == null || !loan.isActive) return 0.0;

    DateTime now = DateTime.now();
    loan.returnDate = now;

    final book = bookRepo.getBookById(loan.bookId);
    if (book == null) return 0.0;

    double fine = FinePolicyService.calculateFine(loan, book, now);
    loan.outstandingFine = fine;

    if (FinePolicyService.getOverdueStatus(loan, now) == 'Missing') {
      book.status = BookStatus.missing;
    } else {
      book.status = BookStatus.available;
    }

    return loan.outstandingFine;
  }
}