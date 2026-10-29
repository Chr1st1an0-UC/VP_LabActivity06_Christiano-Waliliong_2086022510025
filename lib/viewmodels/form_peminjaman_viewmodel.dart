import 'package:flutter/foundation.dart';

class FormPeminjamanViewModel extends ChangeNotifier {
  String studentId = '';
  String selectedBookId = '';

  void setStudentId(String id) {
    studentId = id;
    notifyListeners();
  }

  void setSelectedBook(String bookId) {
    selectedBookId = bookId;
    notifyListeners();
  }
}