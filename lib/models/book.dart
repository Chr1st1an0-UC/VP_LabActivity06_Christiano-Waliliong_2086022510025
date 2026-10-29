enum BookStatus { available, borrowed, missing }

class Book {
  final String id;          // ID unik per eksemplar fisik
  final String title;
  final String author;
  final double replacementPrice;
  BookStatus status;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.replacementPrice,
    this.status = BookStatus.available,
  });

  factory Book.fromJson(Map<String, dynamic> json, String id, BookStatus status) {
    return Book(
      id: id,
      title: json['title'],
      author: json['author'],
      replacementPrice: (json['replacementPrice'] as num).toDouble(),
      status: status,
    );
  }
}

class BookGroup {
  final String title;
  final String author;
  final double replacementPrice;
  final List<Book> books;

  BookGroup({
    required this.title,
    required this.author,
    required this.replacementPrice,
    required this.books,
  });

  int get totalQuantity => books.length;
  int get availableQuantity => books.where((b) => b.status == BookStatus.available).length;
  
  String? getAvailableBookId() {
    try {
      return books.firstWhere((b) => b.status == BookStatus.available).id;
    } catch (_) {
      return null;
    }
  }
}