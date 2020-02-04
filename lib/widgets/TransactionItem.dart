import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: FittedBox(
                  child: Text(
                      '\$${transaction.amount.toStringAsFixed(2)}'))),
        ),
        title: Text(
          transaction.title,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width >500
            ?
        FlatButton.icon(onPressed:  () => deleteTx(transaction.id),

            icon: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteTx(transaction.id),
              color: Theme.of(context).errorColor,
            ), label: Text("Delete",style: TextStyle( color :Theme.of(context).errorColor),)):
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => deleteTx(transaction.id),
          color: Theme.of(context).errorColor,
        ),
        // ال onPressed ما بتاخد argument  علشان هيك عملناها زي الي فوق
      ),
    );
  }
}

