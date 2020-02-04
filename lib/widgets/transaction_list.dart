import 'package:flutter/material.dart';
import '../models/transaction.dart';

//ال intel ال dateTime
import 'package:intl/intl.dart';
import './TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTx;

  TransactionList(this.userTransaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {// بتعمل نسبة و تناسب بين العناصر اما ال media  بتعمل نسبة و تناسب بالنسبة لحجم الجهاز
            return Column(
              children: <Widget>[
                Text("No transactions added yet"),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView(
            children: [
              ...userTransaction
                .map((tx) => TransactionItem(
              transaction: tx,
              deleteTx: deleteTx,
            ))
                .toList(),]
          );
    /* Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(
                          '\$${userTransaction[index].amount.toStringAsFixed(2)}',
                          //علشان تاخد رقمين بعد الفاصلة
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .primaryColorDark), //علشان تاخد لون ال theme
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.purple,
                                width: 5,
                                style: BorderStyle.solid)),
                        padding: EdgeInsets.all(5),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userTransaction[index].title,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(userTransaction[index].date),
                            style: TextStyle(color: Colors.blueGrey),
                          )
                        ],
                      )
                    ],
                  ),
                )*/
  }
}
