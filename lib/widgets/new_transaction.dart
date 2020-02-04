import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //علشان ما يحذفلي البيانات داخل ال TextField لما انتقل لل TextField التانية ,,خليتها Statefull
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate; //هادي مش فاينل علشان ما عندها قيمة مبدأية وانما قيمتها بتكون لما المستخدم يختار التاريخ
  void _submitData() {
    if(amountController.text.isEmpty ){
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
    //علشان لما اضغط على ال submit ينزل ال card
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(top: 10,left: 10,right: 10 , bottom: MediaQuery.of(context).viewInsets.bottom +10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "title"),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "amount"),
                //وظيفة ال controller يعمل save لل user input
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: <Widget>[
                  // هلأ بال Expanded رح تاخد اكبر مساحة بتقدر تاخدها و ال flatbutton رح  ياخد المساحة الي بحتاجها
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : " chosen date ${DateFormat.yMd().format(_selectedDate)}"),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentDatePicker,
                      child: Text("Chose Date "))
                ],
              ),
              RaisedButton(
                child: Text(
                  "add transaction",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
