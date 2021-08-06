import 'package:flutter/material.dart';

import 'widgets/chart.dart';
import 'widgets/new_trasaction.dart';
import '/models/transaction.dart';
import '/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransaction = [];

  List<Transaction> get _recenttransactions {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _add_new_transaction(
      String txtitle, double txamount, DateTime choosendate) {
    final newTrans = Transaction(
      title: txtitle,
      amount: txamount,
      date: choosendate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _usertransaction.add(newTrans);
    });
  }

  void _start_add_new_transaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_add_new_transaction);
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Flutter App'),
      actions: [
        IconButton(
          onPressed: () => _start_add_new_transaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body:  SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height-MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recenttransactions),
              ),
              Container(
                 height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height-MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_usertransaction, deleteTransaction),
              ),
            ],
          ),
      ),
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _start_add_new_transaction(context),
        // backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
