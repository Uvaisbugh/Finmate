import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finmate/models/transaction/transaction_model.dart';
import 'package:finmate/models/category/category_model.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // Aggregated data for the selected month
  List<PieChartSectionData> pieSections = [];
  List<MapEntry<String, double>> topCategories = [];
  double totalIncome = 0;
  double totalExpense = 0;

  final List<Color> categoryPalette = [
    Color(0xFF42A5F5), // Blue
    Color(0xFF66BB6A), // Green
    Color(0xFFFFA726), // Orange
    Color(0xFFAB47BC), // Purple
    Color(0xFFEF5350), // Red
    Color(0xFFFFCA28), // Yellow
    Color(0xFF26C6DA), // Cyan
    Color(0xFF8D6E63), // Brown
    Color(0xFFEC407A), // Pink
    Color(0xFF7E57C2), // Deep Purple
  ];

  @override
  void initState() {
    super.initState();
    _processAnalytics();
  }

  void _processAnalytics() {
    final transactionBox = Hive.box<Transaction>('transactionBox');
    final categoryBox = Hive.box<Category>('categoryBox');
    final allTransactions = transactionBox.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    // Filter by selected month/year
    final filtered =
        allTransactions
            .where(
              (txn) =>
                  txn.date.month == selectedMonth &&
                  txn.date.year == selectedYear,
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    // Aggregate by category (expenses only)
    final Map<String, double> categoryTotals = {};
    for (var txn in filtered) {
      if (txn.amount < 0) {
        categoryTotals[txn.categoryId] =
            (categoryTotals[txn.categoryId] ?? 0) + txn.amount.abs();
      }
    }

    // Aggregate income/expense totals
    double income = 0;
    double expense = 0;
    for (var txn in filtered) {
      if (txn.amount > 0) {
        income += txn.amount;
      } else {
        expense += txn.amount.abs();
      }
    }

    // Top categories (expenses)
    final topCats = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Pie chart sections with unique colors
    final List<PieChartSectionData> pie = topCats
        .take(5)
        .toList()
        .asMap()
        .entries
        .map((entry) {
          final idx = entry.key;
          final catEntry = entry.value;
          final category = categoryBox.values.firstWhere(
            (cat) => cat.id == catEntry.key,
            orElse: () => Category(
              id: catEntry.key,
              name: catEntry.key,
              type: CategoryType.expense,
            ),
          );
          final color = categoryPalette[idx % categoryPalette.length];
          return PieChartSectionData(
            color: color,
            value: catEntry.value,
            title: category.name,
          );
        })
        .toList();
    if (pie.isEmpty) {
      pie.add(
        PieChartSectionData(
          color: Colors.grey[300]!,
          value: 1,
          title: 'No Data',
        ),
      );
    }

    setState(() {
      pieSections = pie;
      topCategories = topCats;
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Horizontal Month Picker
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: months.length,
              separatorBuilder: (context, i) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final isSelected = (i + 1) == selectedMonth;
                return ChoiceChip(
                  label: Text(months[i]),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedMonth = i + 1;
                    });
                    _processAnalytics();
                  },
                  selectedColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Pie Chart: Spending by Category (filtered by selectedMonth)
          const Text(
            'Spending by Category',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: pieSections,
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Bar Chart: Income vs Expense for the month
          const Text(
            'Income vs Expense',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: totalIncome, color: Colors.green),
                      BarChartRodData(toY: totalExpense, color: Colors.red),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) return const Text('0');
                        if (value >= 1000) {
                          return Text('${(value ~/ 1000)}k');
                        }
                        return Text(value.toInt().toString());
                      },
                      reservedSize: 40, // Ensures enough space for labels
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == 0) {
                          return const Text('This Month');
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Top Categories (filtered by selectedMonth)
          const Text(
            'Top Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          ...topCategories.take(5).toList().asMap().entries.map((entry) {
            final idx = entry.key;
            final catEntry = entry.value;
            final categoryBox = Hive.box<Category>('categoryBox');
            final category = categoryBox.values.firstWhere(
              (cat) => cat.id == catEntry.key,
              orElse: () => Category(
                id: catEntry.key,
                name: catEntry.key,
                type: CategoryType.expense,
              ),
            );
            final color = categoryPalette[idx % categoryPalette.length];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: const Icon(Icons.category, color: Colors.white),
              ),
              title: Text(category.name),
              trailing: Text(
                '₹${catEntry.value.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
          if (topCategories.isEmpty)
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.category, color: Colors.white),
              ),
              title: Text('No Data'),
              trailing: Text(
                '₹0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
// This code defines an AnalyticsScreen that displays financial analytics using charts and lists.
// It includes a horizontal month picker, a pie chart for spending by category, a bar chart