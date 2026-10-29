class Loan {
  final String loanId;
  final String bookId;
  final String studentId;
  final DateTime borrowingDate;
  final DateTime dueDate;
  DateTime? returnDate;
  double outstandingFine;

  Loan({
    required this.loanId,
    required this.bookId,
    required this.studentId,
    required this.borrowingDate,
    required this.dueDate,
    this.returnDate,
    this.outstandingFine = 0.0,
  });

  bool get isActive => returnDate == null;
}