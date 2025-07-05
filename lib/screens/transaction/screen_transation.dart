import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: 12,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('${(index + 1) * 1000} INR'),
            subtitle: Text(
              'Category ${index + 1} - ${DateTime.now().subtract(Duration(days: index)).toLocal().toIso8601String().split('T')[0]}',
            ),
            trailing: Text(
              index % 2 == 0 ? 'Income' : 'Expense',
              style: TextStyle(
                color: index % 2 == 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
