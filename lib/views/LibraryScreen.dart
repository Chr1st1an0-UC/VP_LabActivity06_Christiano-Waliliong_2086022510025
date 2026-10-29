import 'package:flutter/material.dart';
import '../viewmodels/library_viewmodel.dart';
import 'widgets/BookCard.dart';
import 'BorrowedBooksScreen.dart';

class LibraryScreen extends StatelessWidget {
  final LibraryViewModel viewModel;

  const LibraryScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan ListenableBuilder dari foundation/flutter untuk memantau perubahan ViewModel
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Katalog Perpustakaan'),
            actions: [
              IconButton(
                icon: const Icon(Icons.list_alt),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BorrowedBooksScreen(viewModel: viewModel),
                    ),
                  );
                },
              )
            ],
          ),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.groupedBooks.isEmpty
                  ? const Center(child: Text('Tidak ada buku di dalam database.'))
                  : ListView.builder(
                      itemCount: viewModel.groupedBooks.length,
                      itemBuilder: (context, index) {
                        final group = viewModel.groupedBooks[index];
                        return BookCard(
                          bookGroup: group,
                          onBorrowPressed: () {
                            bool success = viewModel.borrowBookByTitle(group.title, 'STUDENT_01');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(success ? 'Berhasil meminjam buku "${group.title}"!' : 'Gagal: Stok habis!'),
                              ),
                            );
                          },
                        );
                      },
                    ),
        );
      },
    );
  }
}