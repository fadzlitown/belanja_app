import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  /// flutter will connect this controller into the field wdget. will listen & save the user's input
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();

  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              ///onChanged: required a String function ({void Function(String) onChanged)
              // onChanged: (val) {
              //   titleInput = val;
              // },
              keyboardType: TextInputType.text,
              controller: titleInput,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              // onChanged: (val) => amountInput = val,
              keyboardType: TextInputType.number,
              controller: amountInput,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: () {
                  // transactions.add(Transaction(
                  //     id: '3',
                  //     title: titleInput.text,
                  //     amount: double.tryParse(amountInput.text),
                  //     dateTime: DateTime.now()));
                  // print(transactions);
                  addTransaction(Transaction(
                      id: DateTime.now().toString(),
                      title: titleInput.text,
                      amount: double.tryParse(amountInput.text),
                      dateTime: DateTime.now()));

                  print(titleInput.text + " " + amountInput.text);
                },
                child: Text('Add Transaction'),
                padding: EdgeInsets.only(left: 20, right: 20),
                color: Colors.purpleAccent,
              ),
            )
          ],
        ),
      ),
      elevation: 5,
    );
  }
}
