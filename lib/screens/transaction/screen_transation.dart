import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finmate/models/category/category_model.dart';
import 'package:finmate/models/transaction/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Transaction>(
              'transactionBox',
            ).listenable(),
            builder: (context, Box<Transaction> box, _) {
              double totalIncome = 0;
              double totalExpense = 0;
              double balance = 0;

              final transactions = box.values.toList().cast<Transaction>();
              for (var transaction in transactions) {
                if (transaction.amount > 0) {
                  totalIncome += transaction.amount;
                } else {
                  totalExpense += transaction.amount.abs();
                }
              }
              balance = totalIncome - totalExpense;

              return Column(
                children: [
                  // Uniform Summary Cards with IntrinsicHeight
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildSummaryCard(
                            title: 'Balance',
                            amount: balance,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.account_balance_wallet_rounded,
                            iconBg: const Color(0xFF1976D2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSummaryCard(
                            title: 'Income',
                            amount: totalIncome,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF43A047), Color(0xFF81C784)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.trending_up_rounded,
                            iconBg: const Color(0xFF388E3C),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSummaryCard(
                            title: 'Expense',
                            amount: totalExpense,
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE53935), Color(0xFFFFB74D)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            icon: Icons.trending_down_rounded,
                            iconBg: const Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Transactions List
                  Expanded(
                    child: transactions.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No transactions yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Add your first transaction using the + button',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: transactions.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              final isIncome = transaction.amount > 0;
                              final category = _getCategoryById(
                                transaction.categoryId,
                              );

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: isIncome
                                      ? Colors.green[100]
                                      : Colors.red[100],
                                  child: Icon(
                                    isIncome
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: isIncome ? Colors.green : Colors.red,
                                  ),
                                ),
                                title: Text(
                                  category?.name ?? transaction.categoryId,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  _formatDate(transaction.date),
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                trailing: Text(
                                  '${isIncome ? '+' : '-'}₹${transaction.amount.abs().toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: isIncome ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                onLongPress: () =>
                                    _showDeleteDialog(context, transaction),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required LinearGradient gradient,
    required IconData icon,
    required Color iconBg,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: iconBg.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '₹${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Category? _getCategoryById(String categoryId) {
    final categoryBox = Hive.box<Category>('categoryBox');
    try {
      return categoryBox.values.firstWhere(
        (category) => category.id == categoryId,
      );
    } catch (e) {
      return null;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showDeleteDialog(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              transaction.delete();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
