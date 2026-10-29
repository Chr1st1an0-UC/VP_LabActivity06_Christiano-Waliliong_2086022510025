import 'package:flutter/material.dart';
import '../viewmodels/library_viewmodel.dart';
import 'widgets/LoanCard.dart';
import 'widgets/FineSummaryCard.dart';

class BorrowedBooksScreen extends StatelessWidget {
  final LibraryViewModel viewModel;

  const BorrowedBooksScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final activeLoans = viewModel.activeLoans;

        return Scaffold(
          appBar: AppBar(title: const Text('Buku Dipinjam & Pengembalian')),
          body: activeLoans.isEmpty
              ? const Center(child: Text('Tidak ada peminjaman aktif.'))
              : ListView.builder(
                  itemCount: activeLoans.length,
                  itemBuilder: (context, index) {
                    final loan = activeLoans[index];
                    final status = viewModel.getLoanOverdueStatus(loan);

                    return LoanCard(
                      loan: loan,
                      statusText: status,
                      onReturnPressed: () {
                        double fine = viewModel.returnBook(loan.loanId);

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Rincian Pengembalian'),
                            content: FineSummaryCard(
                              amount: fine,
                              statusText: status,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text('OK'),
                              ),
                            ],
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