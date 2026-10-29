import '../loan.dart';

class LoanRepository {
  final List<Loan> _loans = [];

  void addLoan(Loan loan) {
    _loans.add(loan);
  }

  List<Loan> getAllLoans() => _loans;

  Loan? getLoanById(String loanId) {
    try {
      return _loans.firstWhere((l) => l.loanId == loanId);
    } catch (_) {
      return null;
    }
  }
}