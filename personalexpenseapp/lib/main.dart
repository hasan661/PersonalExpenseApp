import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'widgets/chart.dart';
import 'widgets/new_trasaction.dart';
import '/models/transaction.dart';
import '/widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _usertransaction = [];

  var boolean = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }

  @override
  dispose(){
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

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
 List <Widget> _buildLandscape(MediaQueryData mediaquery, AppBar
   appbar, transactionList)
  {
    return  [Row(
              children: [
                Text("Show Chart", style: Theme.of(context).textTheme.headline6,),
                Switch.adaptive(
                    value: boolean,
                    onChanged: (val) {
                      setState(() {
                        boolean = val;
                      });
                    })
              ],
            ), boolean
                ? Container(
                    height: (mediaquery.size.height -
                            appbar.preferredSize.height -
                            mediaquery.padding.top) *
                        0.7,
                    child: Chart(_recenttransactions),
                  )
                : transactionList];

  }

  List<Widget> _buildPortrait(MediaQueryData mediaquery, AppBar
   appbar, transactionList)
  {
    return [Container(
              height: (mediaquery.size.height -
                      appbar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.3,
              child: Chart(_recenttransactions),
            ),transactionList];

  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final dynamic appbar = Platform.isAndroid
        ? AppBar(
            title: Text('Flutter App'),
            actions: [
              IconButton(
                onPressed: () => _start_add_new_transaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          )
        : CupertinoNavigationBar(
            middle: Text("Flutter App"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _start_add_new_transaction(context),
              )

            ],),
            
          );
    final transactionList = Container(
      height: (mediaquery.size.height -
              appbar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(_usertransaction, deleteTransaction),
    );
    var pagebody =SafeArea(child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
           ..._buildLandscape(mediaquery, appbar,transactionList),
          if (!isLandscape)
            ..._buildPortrait(mediaquery, appbar,transactionList),
        
           
        ],
      ),
    ) ); 
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            body: pagebody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _start_add_new_transaction(context),
                    // backgroundColor: Theme.of(context).primaryColor,
                  ),
          );
  }
}
