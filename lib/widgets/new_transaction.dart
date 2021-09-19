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

              /// when Function(String) accepting annoymous func with parameter value
              /// --> we can used (_) means WE DONT USE THIS VAL!
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              // onChanged: (val) => amountInput = val,
              keyboardType: TextInputType.number,
              controller: amountInput,
              decoration: InputDecoration(labelText: 'Amount'),

              /// when arg accepting annoymous func with parameter value --> can used (_) means WE DONT USE THIS VAL!
              onSubmitted: (_) => submitData(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: submitData,
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

  void submitData() {
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTransaction(Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        dateTime: DateTime.now()));
  }
}
