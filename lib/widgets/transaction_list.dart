import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;

  TransactionList(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
            children: list.map((e) {
          return Card(
              child: Row(
                children: [
                  Container(
                    child: Icon(CupertinoIcons.money_dollar),
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    child: Text('\$' + '${e.amount}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.purpleAccent, width: 2.0)),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          e.title.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                        margin: EdgeInsets.only(bottom: 8),
                      ),
                      Text(
                        // DateFormat('EEE, MMM d, ' 'yy')
                        //     .format(e.dateTime),
                        DateFormat().add_yMEd().format(e.dateTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],

                    /// left to right
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
              elevation: 5);
        }).toList()),
      ),
    );
  }
}
