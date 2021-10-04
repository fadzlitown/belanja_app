import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction item;
  final Function deleteTransaction;

  /// what is a generated key in Widget?
  /// Most of the StatelessWidget no need a key.
  /// keys only matter if you're working with stateful widgets in a list
  /// Flutter may attach a state object to the wrong widget (if widgets moved or where deleted) if you're not using keys.
  const TransactionItem({this.item, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        ///CircleAvatar use to create a circle shape
        /// alternative option, can used Container with fix size & BoxShape.circle shape decoration
        leading: CircleAvatar(
          radius: 30,

          /// Can use Padding instead of Container which padding defined.
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: FittedBox(child: Text('\$ ${item.amount}'))),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle:

            /// const Text(..) = TAK BOLEH bcs dateTime is dynamic content
            Text(DateFormat.yMMMd().format(item.dateTime)),

        /// Adding condition based on device size using MediaQuery size (not checking on orientation but sizes)
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () {
                  deleteTransaction(item.id);
                },
                icon: const Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,

                /// const Text('Delete') = boleh letak const bcs 'Delete' val TIDAK AKAN BERUBAH!!
                label: const Text('Delete'))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  deleteTransaction(item.id);
                },
              ),
      ),
    );
    ;
  }
}
