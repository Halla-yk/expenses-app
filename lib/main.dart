import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
//  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);// علشان اوقف ال landscape mode
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
        debugShowCheckedModeBanner: false, // لحذف ال debug banner
        theme: ThemeData(
            errorColor: Colors.red,
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            // FloatingActionButton لون بديل بياخده ال
            fontFamily: 'OpenSansCondensed',
            textTheme: ThemeData.light()
                .textTheme
                .copyWith(button: TextStyle(color: Colors.white))));
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
//    Transaction(
//        amount: 30.0, date: DateTime.now(), id: "12345", title: "shirt"),
//    Transaction(amount: 90.0, date: DateTime.now(), id: "12895", title: "pant")
  ];

  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
          Duration(days: 7))); // بتجيب الايام الي من بعد تاريخ اليوم -7
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
      String newTilte, double newAmount, DateTime selectedDate) {
    final newTx = Transaction(
        title: newTilte,
        amount: newAmount,
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //علشان تطلع من تحت
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {}, //علشان لما اضغط عليها ما تختفي ,,بتختفي بس اضغط برة
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return id == tx.id;
        //ازا كان true رح تعمل remove
      });
    });
  }

 List<Widget>  _buildLandscapeContent(MediaQueryData mediaQuery , AppBar appBar ,Widget txWidget){
    return[ Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("show chart"),
        Switch(
          value: _showChart,
          onChanged: (val) {
            // لما يكون ال  switch  شغال flutter بحط ال  val on والعكس صحيح
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    ),_showChart
        ? Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.7,
        child: Chart(_recentTransaction))
        : txWidget];

  }

  List<Widget>_buildPortraitContent(MediaQueryData mediaQuery , AppBar appBar ,Widget txWidget){
    return [ Container(
        height: (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransaction)),txWidget]
     ;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery  = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("flutter app"),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    final txWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
            mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            if (isLandscape)
         ... _buildLandscapeContent(mediaQuery, appBar,txWidget),
            if (!isLandscape)
             ... _buildPortraitContent(mediaQuery, appBar,txWidget),


          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
