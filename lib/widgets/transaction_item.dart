import 'dart:math';

import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction item;
  final Function deleteTransaction;

  /// what is a generated key in Widget?
  /// Most of the StatelessWidget no need a key, except StatefulWidget (required key sometimes)
  /// Flutter may attach a state object to the wrong widget (if widgets moved or where deleted) if you're not using keys.
  const TransactionItem({Key key, this.item, this.deleteTransaction})
      : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  MaterialColor _bgColor;

  @override
  void initState() {
    // before build() runs, setup here
    const availableColors = [Colors.red, Colors.grey, Colors.green];
    _bgColor = availableColors[Random().nextInt(availableColors.length)];
    super.initState();
  }

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
          backgroundColor: _bgColor,

          /// Can use Padding instead of Container which padding defined.
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: FittedBox(child: Text('\$ ${widget.item.amount}'))),
        ),
        title: Text(
          widget.item.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle:

            /// const Text(..) = TAK BOLEH bcs dateTime is dynamic content
            Text(DateFormat.yMMMd().format(widget.item.dateTime)),

        /// Adding condition based on device size using MediaQuery size (not checking on orientation but sizes)
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () {
                  widget.deleteTransaction(widget.item.id);
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
                  widget.deleteTransaction(widget.item.id);
                },
              ),
      ),
    );
    ;
  }
}
