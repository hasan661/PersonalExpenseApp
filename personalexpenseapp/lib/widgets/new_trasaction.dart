import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final title = TextEditingController();

  final amount = TextEditingController();

  var _selecteddate;

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
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10),
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
                    TextButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              TextButton(
                onPressed: submit,
                child: Text(
                  "Add Transaction",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
