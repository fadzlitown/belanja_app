import 'package:flutter/cupertino.dart';

class Transaction {
  // blueprint model, normal class

  String id;
  String title;
  double amount;

  //DateTime dart lib
  DateTime dateTime;

  /// add required like non-null value. is a must arguments!
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.dateTime});
}
