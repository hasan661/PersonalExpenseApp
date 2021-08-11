import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.delete,
  }) : super(key: key);

  final Transaction transaction;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(radius: 30, child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(child: Text('\$${transaction.amount}'))),
          ),
          title: Text(transaction.title,style:Theme.of(context).textTheme.headline6),
          subtitle: Text(DateFormat.yMMMd().format(transaction.date) ),
          trailing: MediaQuery.of(context).size.width> 460 ? TextButton.icon(onPressed: (){delete(transaction.id);}, label: Text("Delete",style: TextStyle(color: Theme.of(context).primaryColor),),icon: Icon(Icons.delete), ) :
          IconButton(onPressed: (){delete(transaction.id);}, icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,),
          
    
    
        
      ),
    );
  }
}
