import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  late final Function createTrans;

  NewTransaction(this.createTrans);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  String pickedDate = 'No date chosen';

  void pickDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        pickedDate = DateFormat.yMd().format(value);
      });
    });
  }

  void submitData() {
    widget.createTrans(
        titleController.text,
        double.parse(amountController.text),
        DateFormat.yMd().parse(pickedDate));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: submitData,
              child: const Text('Add Transaction'),
            ),
            Row(
              children: [
                Text(pickedDate,
                    style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                    onPressed: pickDate,
                    icon: const Icon(Icons.edit_calendar_rounded)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
