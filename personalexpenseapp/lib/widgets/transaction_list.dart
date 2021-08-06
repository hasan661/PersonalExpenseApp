import 'package:flutter/material.dart';
import 'package:personalexpenseapp/models/transaction.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
   
      return transactions.isEmpty
          ? Column(
              children: [
                Text("No Transactions Added Yet"),
                SizedBox(height: 20,),
                Container(
                  height: 200,
                    child: Image.asset(
                  'images/waiting.png',
                  fit: BoxFit.cover,
                )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(radius: 30, child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(child: Text('\$${transactions[index].amount}'))),
                      ),
                      title: Text(transactions[index].title,style:Theme.of(context).textTheme.headline6),
                      subtitle: Text(DateFormat.yMMMd().format(transactions[index].date) ),
                      trailing: IconButton(onPressed: (){delete(transactions[index].id);}, icon: Icon(Icons.delete),color: Theme.of(context).primaryColor,),
                      
                
                
                    
                  ),
                );
              },
              itemCount: transactions.length,
            
    );
  }
}
