import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';

import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1', title: 'New Shirt', amount: 29.99, dateTime: DateTime.now()),
    Transaction(
        id: '2', title: 'Cap NY', amount: 40.89, dateTime: DateTime.now())
  ];

  void _addTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),

        /// pass the func pointer here
        TransactionList(_userTransactions)

        /// pass the variable list here
      ],
    );
  }
}
