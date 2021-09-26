import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  double spendingAmount;
  double spendingTotalAmount;

  ChartBar(this.label, this.spendingAmount, this.spendingTotalAmount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///FittedBox : Scales and positions its child widget within itself, by forcing Text not to grow its space
        Container(
            height: 20,
            child: FittedBox(
                child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 1, 1),
                    borderRadius: BorderRadius.circular(10)

                    /// corner border
                    ),
              ),

              /// a box that sized as a fraction by value
              FractionallySizedBox(
                  heightFactor: spendingTotalAmount,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label)
      ],
    );
  }
}
