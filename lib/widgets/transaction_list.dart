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

      /// NOTE:
      /// ListView() -> good for short list
      ///  -> will render all UI list item including the invisible items (expensive processes, less performance)
      /// ListView.builder() -> only render the visible items, load when the item can be seen .
      /// -- > lazily rendering widgets

      child: ListView.builder(
        /// itemBuilder is a must --> pass Widget view, used list with current position like RecyclerView
        /// itemCount -> list count
        itemBuilder: (ctx, pos) {
          return Card(
              child: Row(
                children: [
                  Container(
                    child: Icon(CupertinoIcons.money_dollar),
                    margin: EdgeInsets.all(5),
                  ),
                  Container(
                    child: Text('\$' + '${list[pos].amount.toStringAsFixed(2)}',
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
                          list[pos].title.toString(),
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
                        DateFormat().add_yMEd().format(list[pos].dateTime),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],

                    /// left to right
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )
                ],
              ),
              elevation: 5);
        },
        itemCount: list.length,
      ),
    );
  }
}
