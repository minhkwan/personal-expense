import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
          textTheme: const TextTheme(
              titleLarge: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.pinkAccent)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactionsList = [];

  void createNewTrans(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      transactionsList.add(newTx);
    });
  }

  void deleteTransaction(int index) {
    setState(() {
      transactionsList.removeAt(index);
    });
  }

  void showNewAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(createNewTrans);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(transactionsList),
            TransactionList(transactionsList, deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          showNewAddTransaction(context);
        },
      ),
    );
  }
}
