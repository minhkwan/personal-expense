import 'package:flutter/material.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function deleteTrans;

  const TransactionList(this.transactionsList, this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: FittedBox(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('\$${transactionsList[index].amount}'))),
              ),
              title: Text(
                transactionsList[index].title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(
                DateFormat('yyyy-MM-dd').format(transactionsList[index].date),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  deleteTrans(index);
                },
              ),
            ),
          );
        },
        itemCount: transactionsList.length,
      ),
    );
  }
}
