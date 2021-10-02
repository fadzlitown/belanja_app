import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String label;
  double spendingAmount;
  double spendingTotalAmount;

  ChartBar(this.label, this.spendingAmount, this.spendingTotalAmount);

  @override
  Widget build(BuildContext context) {
    /// LayoutBuilder has constraints function
    /// = LinearLayout weight to distribute the spaces between widgets
    /// each widget needs to set -> height: constraints.maxHeight * (no % height)
    /// MAKE SURE THE TOTAL no of height + = 1
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          ///FittedBox : Scales and positions its child widget within itself, by forcing Text not to grow its space
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            /// the max height size of chartbar that may takes
            height: constraints.maxHeight * 0.6,
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
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
