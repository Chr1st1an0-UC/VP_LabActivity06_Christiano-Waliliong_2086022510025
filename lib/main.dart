import 'package:flutter/material.dart';
import 'viewmodels/library_viewmodel.dart';
import 'views/LibraryScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Membuat instance ViewModel secara langsung
    final LibraryViewModel libraryViewModel = LibraryViewModel();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Perpustakaan',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Mengoper ViewModel ke LibraryScreen tanpa package provider
      home: LibraryScreen(viewModel: libraryViewModel),
    );
  }
}