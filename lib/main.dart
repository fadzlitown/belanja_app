import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../transaction.dart';

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
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: '1', title: 'New Shirt', amount: 29.99, dateTime: DateTime.now()),
    Transaction(
        id: '2', title: 'Cap NY', amount: 40.89, dateTime: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Belanja App'),
        ),
        body: Column(

            /// Column widget important in layout!
            ///mainAxisAlignment starting from top->bottom,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            ///crossAxisAlignment starting from left -> right. def is center
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Container(
                  ///NOTED the widget Text will takes a measurement of the parent.
                  ///mcm XML view dlm FrameLayout / any layout. Need to learn by doing not read
                  child: Text(
                    'Chart',
                    textAlign: TextAlign.start,
                  ),
                  width: double.infinity,
                  color: Colors.blue,
                  padding: EdgeInsets.all(10.0),
                ),
                elevation: 5,
              ),
              Column(
                  children: transactions.map((e) {
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.purpleAccent, width: 2.0)),
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
                              DateFormat('EEE, MMM d, ' 'yy')
                                  .format(e.dateTime),
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],

                          /// left to right
                          crossAxisAlignment: CrossAxisAlignment.start,
                        )
                      ],
                    ),
                    elevation: 5);
              }).toList())
            ]));
  }
}
