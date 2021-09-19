import 'package:belanja_app/widgets/new_transaction.dart';
import 'package:belanja_app/widgets/transaction_list.dart';
import 'package:belanja_app/widgets/user_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Belanja App'),
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
                UserTransaction()
              ]),
        ));
  }
}
