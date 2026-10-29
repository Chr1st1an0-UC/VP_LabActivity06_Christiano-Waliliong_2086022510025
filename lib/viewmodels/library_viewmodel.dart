import 'package:flutter/foundation.dart';
import '../models/repositories/book_repo.dart';
import '../models/repositories/loan_repo.dart';
import '../models/services/book_service.dart'; // Import service Anda
import '../models/book.dart';
import '../models/loan.dart';
import '../models/services/fine_policy_service.dart';

class LibraryViewModel extends ChangeNotifier {
  final BookRepository bookRepo = BookRepository();
  final LoanRepository loanRepo = LoanRepository();
  late final BookService bookService; // Inisialisasi Service di sini
  
  bool isLoading = true;

  LibraryViewModel() {
    bookService = BookService(bookRepo: bookRepo, loanRepo: loanRepo);
    initData();
  }

  Future<void> initData() async {
    isLoading = true;
    notifyListeners();
    
    // Memanggil service untuk mengambil JSON dan menginisialisasi model
    await bookService.loadAndInitializeBooks();
    
    isLoading = false;
    notifyListeners();
  }

  List<Loan> get loans => loanRepo.getAllLoans();
  List<Loan> get activeLoans => loans.where((l) => l.isActive).toList();

  List<BookGroup> get groupedBooks {
    final allBooks = bookRepo.getBooks();
    final Map<String, List<Book>> map = {};

    for (var book in allBooks) {
      if (!map.containsKey(book.title)) {
        map[book.title] = [];
      }
      map[book.title]!.add(book);
    }

    return map.entries.map((entry) {
      final firstBook = entry.value.first;
      return BookGroup(
        title: entry.key,
        author: firstBook.author,
        replacementPrice: firstBook.replacementPrice,
        books: entry.value,
      );
    }).toList();
  }

  bool borrowBookByTitle(String bookTitle, String studentId) {
    final groupList = groupedBooks.where((g) => g.title == bookTitle);
    if (groupList.isEmpty) return false;

    final group = groupList.first;
    final availableBookId = group.getAvailableBookId();

    if (availableBookId == null) return false;

    // Memanfaatkan bookService untuk proses peminjaman
    bool success = bookService.borrowBook(availableBookId, studentId);
    if (success) notifyListeners();
    return success;
  }

  double returnBook(String loanId) {
    // Memanfaatkan bookService untuk proses pengembalian & denda
    double fine = bookService.returnBook(loanId);
    notifyListeners();
    return fine;
  }

  String getLoanOverdueStatus(Loan loan) {
    return FinePolicyService.getOverdueStatus(loan);
  }
}