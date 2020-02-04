import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) { //ال index بيبدأ من صفر و بضلو يزيد  ل6
       final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0,2),
        'amount': totalSum
      }; // ال amount و ال day عبارة عن properties لكل ال items في ال list
    }).reversed.toList();
  }

  double get totalSpending {
    // ال item عبارة عن object من ال list
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum +
          item[
              'amount']; // هاي ال method بتاخد قيمة ابتدائية و بتتنفذ لكل item في هاي ال list
    });
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var weekdayNumber = today.weekday;
    print(weekdayNumber);
      return

      Card(
      elevation: 8,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) { // هادي عبارة عم ال method لي بدي انفذها لكل  object من ال  chartBar
            return  Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'], data['amount'],
                 totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
