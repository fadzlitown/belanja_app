import 'package:belanja_app/widgets/chart.dart';
import 'package:belanja_app/widgets/new_transaction.dart';
import 'package:belanja_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          ///primarySwatch = diff shade of colors, primaryColor = single color
          /// will reflect to the appbar & other undefined floating button
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          fontFamily: 'OpenSans',

          /// TITLE THEME WIDGET : headline6
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(

              /// TITLE APPBAR THEME
              /// AppBarTheme has own text theme which we could override, all title text in the app
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1', title: 'New Shirt', amount: 29.99, dateTime: DateTime.now()),
    Transaction(
        id: '2', title: 'Cap NY', amount: 40.89, dateTime: DateTime.now())
  ];

  List<Transaction> get _getRecentTransactions {
    /// where : Returns a new lazy [Iterable] with all elements that satisfy to below condition
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(_addTransaction),
              onTap: () {},

              ///avoid the sheet not close when top on it
              behavior: HitTestBehavior.opaque);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Belanja App',
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.amber,
              ),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(

            /// Column widget important in layout!
            ///mainAxisAlignment starting from top->bottom,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.start,

            ///crossAxisAlignment starting from left -> right. def is center
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Chart(recentTransactions: _getRecentTransactions),
                elevation: 5,
              ),

              /// NewTransaction(_addTransaction),   --> already handle in BottomSheet!

              /// pass the func pointer here
              TransactionList(_userTransactions)
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
