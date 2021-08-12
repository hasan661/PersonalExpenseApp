import 'dart:math';

import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.delete,
  }) : super(key: key);

  final Transaction transaction;
  final Function delete;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgcolor=Colors.red;
  @override
  void initState() {
    const availaiblecolors=[
      Colors.black,Colors.red,Colors.grey,Colors.green
    ];

    _bgcolor=availaiblecolors[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgcolor,
          radius: 30, child: Padding(
        
          
          padding: EdgeInsets.all(6),
          child: FittedBox(child: Text('\$${widget.transaction.amount}'))),
          ),
          title: Text(widget.transaction.title,style:Theme.of(context).textTheme.headline6),
          subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date) ),
          trailing: MediaQuery.of(context).size.width> 460 ? TextButton.icon(onPressed: (){widget.delete(widget.transaction.id);}, label: Text("Delete",style: TextStyle(color: Theme.of(context).primaryColor),),icon: Icon(Icons.delete), ) :
          IconButton(onPressed: (){widget.delete(widget.transaction.id);}, icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,),
          
    
    
        
      ),
    );
  }
}
