import '/models/loan.dart';
import '/models/book.dart';

class FinePolicyService {
  static const double weeklyFineRate = 10000.0;

  static String getOverdueStatus(Loan loan, [DateTime? mockNow]) {
    DateTime checkDate = mockNow ?? loan.returnDate ?? DateTime.now();
    
    if (checkDate.isBefore(loan.dueDate) || checkDate.isAtSameMomentAs(loan.dueDate)) {
      return 'Tepat Waktu';
    }

    int differenceInMonths = (checkDate.year - loan.dueDate.year) * 12 + (checkDate.month - loan.dueDate.month);
    if (differenceInMonths >= 6 || checkDate.isAfter(loan.dueDate.add(const Duration(days: 180)))) {
      return 'Missing';
    }

    return 'Terlambat';
  }

  static double calculateFine(Loan loan, Book book, [DateTime? mockNow]) {
    DateTime checkDate = mockNow ?? loan.returnDate ?? DateTime.now();
    
    if (checkDate.isBefore(loan.dueDate) || checkDate.isAtSameMomentAs(loan.dueDate)) {
      return 0.0;
    }

    if (getOverdueStatus(loan, checkDate) == 'Missing') {
      return book.replacementPrice;
    }

    int differenceInDays = checkDate.difference(loan.dueDate).inDays;
    int completedWeeks = (differenceInDays / 7).ceil();
    
    return completedWeeks * weeklyFineRate;
  }
}