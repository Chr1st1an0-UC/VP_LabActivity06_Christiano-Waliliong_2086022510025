import '../book.dart';

class BookRepository {
  List<Book> _books = [];

  // Menerima data yang sudah diinisialisasi oleh Service
  void setBooks(List<Book> books) {
    _books = books;
  }

  List<Book> getBooks() => _books;

  Book? getBookById(String id) {
    try {
      return _books.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  void updateBookStatus(String id, BookStatus status) {
    final book = getBookById(id);
    if (book != null) {
      book.status = status;
    }
  }
}