import 'package:flutter/material.dart';
import 'package:personalexpenseapp/models/transaction.dart';
import 'transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete;

  TransactionList(this.transactions, this.delete);

  @override
  Widget build(BuildContext context) {
   
      return transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return Column(
              children: [
                Text("No Transactions Added Yet"),
                SizedBox(height: 20,),
                Container(
                  height: constraints.maxHeight*0.6,
                    child: Image.asset(
                  'images/waiting.png',
                  fit: BoxFit.cover,
                )),
              ],
            );
          }) 
          : ListView(children: [
            ...transactions.map((e) => TransactionItem(key:   ValueKey(e.id),transaction: e, delete: delete)).toList()
          ]
              
    );
  }
}

