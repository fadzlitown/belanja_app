import 'package:belanja_app/models/transaction.dart';
import 'package:belanja_app/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      //2. group the transaction with days & week
      // harini - index 0 = harini , harini - index 1 = semalam ...
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].amount;
        }
      }
      print('day ' +
          DateFormat.E().format(weekDay).substring(0, 1) +
          'amount ' +
          totalSum.toString());

      //1. return a map with key pair value (value that mixed objs)
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get getMaxSpending {
    ///fold = allow to change a list with another TYPE of CERTAIN LOGIC that we pass in the funcs
    /// 0.0 = starting val
    /// iterable.fold(0, (prev, element) => prev + element)
    return groupTransactionValues.fold(0.0, (prevVal, element) {
      return prevVal + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupTransactionValues);

    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            /// 7 bar generated dynamically
            children: groupTransactionValues.map((data) {
              /// by default all the child has the same space
              /// flex: has a capability to take another child space
              return Flexible(
                /// FlexFit.tight = force a child to its width, sized & cant grow!
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    getMaxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / getMaxSpending),
              );
            }).toList(),
          ),
        ));
  }
}
