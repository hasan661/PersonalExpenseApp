import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:personalexpenseapp/widgets/adaptive.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print("New Transaction Constructor");
  }

  @override
  _NewTransactionState createState() {
    print("Create State Constructor");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final title = TextEditingController();

  final amount = TextEditingController();

  var _selecteddate;

  NewTransaction() {
    print("New Transaction Constructor");
  }

  @override
  void initState() {
    print("Init State");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    print("DidUpdate");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }

  void submit() {
    if (amount.text.isEmpty) {
      return;
    }
    final tit = title.text;
    final amm = amount.text;
    if (tit.isEmpty || amm.isEmpty || _selecteddate == null) {
      return;
    }
    widget.addTx(
      title.text,
      double.parse(amount.text),
      _selecteddate,
    );
    Navigator.of(context).pop();
    // print(widget.addTx);
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selecteddate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: title,
                // onSubmitted: (_)=>submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amount,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_selecteddate == null
                        ? 'No Date Choosen'
                        : DateFormat.yMd().format(_selecteddate)),
                    Adaptive("Choose Date", _presentDatePicker)
                  ],
                ),
              ),
              TextButton(
                onPressed: submit,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
