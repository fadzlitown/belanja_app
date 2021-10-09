import 'package:belanja_app/models/transaction.dart';
import 'package:belanja_app/widgets/transaction_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> list;
  Function deleteTransaction;

  TransactionList(this.list, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    print('build TransactionList');

    return Container(
        height: 450,

        /// NOTE:
        /// ListView() -> good for short list
        ///  -> will render all UI list item including the invisible items (expensive processes, less performance)
        /// ListView.builder() -> only render the visible items, load when the item can be seen .
        /// -- > lazily rendering widgets

        child: list.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.05,
                      ),

                      /// const Text('..') = boleh letak const bcs 'No Transactions yet' val TIDAK AKAN BERUBAH!!, const tells Flutter the value will never change!
                      /// good for performance
                      const Text('No Transactions yet'),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset('assets/images/coronavirus.png',

                            /// BoxFit.cover respect the boundary of the container
                            fit: BoxFit.cover),
                      )
                    ],
                  );
                },
              )
            : ListView(
                children: list
                    .map((item) => TransactionItem(
                        key: ValueKey(item.id),
                        item: item,
                        deleteTransaction: deleteTransaction))
                    .toList())
        // ListView.builder(
        //         /// itemBuilder is a must --> pass Widget view, used list with current position like RecyclerView
        //         /// itemCount -> list count
        //         itemBuilder: (ctx, pos) {
        //           /// Option 1 = Card
        //           // return Card(
        //           //     child: Row(
        //           //       children: [
        //           //         Container(
        //           //           child: Icon(CupertinoIcons.money_dollar),
        //           //           margin: EdgeInsets.all(5),
        //           //         ),
        //           //         Container(
        //           //           child: Text(
        //           //               '\$' + '${list[pos].amount.toStringAsFixed(2)}',
        //           //               style: TextStyle(
        //           //                   fontWeight: FontWeight.bold,
        //           //                   color: Theme.of(context).primaryColor)),
        //           //           margin: EdgeInsets.symmetric(
        //           //               horizontal: 20, vertical: 15),
        //           //           decoration: BoxDecoration(
        //           //               border: Border.all(
        //           //                   color: Theme.of(context).primaryColor,
        //           //                   width: 2.0)),
        //           //           padding: EdgeInsets.all(10),
        //           //         ),
        //           //         Column(
        //           //           children: [
        //           //             Container(
        //           //               ///if this text require a specific theming, we need to define globally at main class
        //           //               child: Text(
        //           //                 list[pos].title.toString(),
        //           //                 style: Theme.of(context).textTheme.headline6,
        //           //               ),
        //           //               margin: EdgeInsets.only(bottom: 8),
        //           //             ),
        //           //             Text(
        //           //               // DateFormat('EEE, MMM d, ' 'yy')
        //           //               //     .format(e.dateTime),
        //           //               DateFormat()
        //           //                   .add_yMEd()
        //           //                   .format(list[pos].dateTime),
        //           //               style:
        //           //                   TextStyle(fontSize: 12, color: Colors.grey),
        //           //             )
        //           //           ],
        //           //
        //           //           /// left to right
        //           //           crossAxisAlignment: CrossAxisAlignment.start,
        //           //         )
        //           //       ],
        //           //     ),
        //           //     elevation: 5);
        //           /// Option 2 = ListTile, Alternative of container view item card,
        //           ///  leading & title, subtitle list items. leading = widget to display before the title
        //           return TransactionItem(
        //               item: list[pos], deleteTransaction: deleteTransaction);
        //         },
        //         itemCount: list.length,
        //       ),
        );
  }
}
