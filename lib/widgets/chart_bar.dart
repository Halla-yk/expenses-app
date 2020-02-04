import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.lable, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx , constrains)
    {
      return
        Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(

                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(height: constrains.maxHeight * 0.15 ,
            child: FittedBox(child: Text(lable)),)
          ],
        );
    });

  }
}
