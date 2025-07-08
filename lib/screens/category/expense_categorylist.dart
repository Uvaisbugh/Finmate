import 'package:flutter/material.dart';

class ExpenseCategorylist extends StatelessWidget {
  const ExpenseCategorylist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: 12,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(index),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Category ${index + 1} deleted')),
            );
          },
          child: Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.money_off),
              title: Text('${(index + 1) * 1000} INR'),
              subtitle: Text(
                'Category ${index + 1} - ${DateTime.now().subtract(Duration(days: index)).toLocal().toIso8601String().split('T')[0]}',
              ),
              trailing: Icon(Icons.delete, color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
