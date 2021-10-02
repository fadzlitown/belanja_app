import 'package:belanja_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Note: IF THIS Transaction is using StatelessWidget, then the title & amount inputs cannot be kept due to stateless
/// Hence change to StatefulWidget instead: bcs State will detach from the UI screen & keep the data
class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  /// flutter will connect this controller into the field wdget. will listen & save the user's input
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  //not final, datetime val can be changed
  DateTime _selectedDate;

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

            /// DatePicker
            Container(
              height: 70,
              child: Row(
                children: [
                  ///Expanded = will takes as much as free space available
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date: ' +
                            DateFormat.yMd().format(_selectedDate)),
                  ),
                  FlatButton(
                      onPressed: () => _showDatePicker(),
                      child: Text('Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      textColor: Theme.of(context).primaryColor)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: MaterialButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
                padding: EdgeInsets.only(left: 20, right: 20),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
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

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    ///  by calling 'widget', we can access the property inside the NewTransaction widget
    widget.addTransaction(Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        dateTime: _selectedDate));

    ///close the top most screen, & context is coming from the State framework
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    ///showDatePicker provided by flutter
    /// return the Future<DateTime> ,
    /// Futures are classes that allow to create obj which will give a val in future. eg. http request
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      /// will be executed after user has choose the date!
      if (value == null) {
        return;
      }

      /// to update UI & rerun the value required state update
      setState(() {
        _selectedDate = value;
      });
    });
  }
}
