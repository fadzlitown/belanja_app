import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String name;
  final Function showDatePicker;

  AdaptiveFlatButton(this.name, this.showDatePicker);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: showDatePicker)
        : FlatButton(
            onPressed: showDatePicker,
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
            textColor: Theme.of(context).primaryColor);
  }
}
