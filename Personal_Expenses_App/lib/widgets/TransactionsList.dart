import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import './transaction_item.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final bool isLandscape;
  TransactionList(this.transactions,this.deleteTransaction,this.isLandscape);
  Widget build(BuildContext context) {
    //print('build() TransactionsList');
    return //SingleChildScrollView(//SingleChildScrollView Works with container,so we have to wrap any child with container to make it scrollable
          /*child:*/ //Container(height: MediaQuery.of(context)., I Already Wrapped It In Another Container So I Removed This
            /*child: Column(*/transactions.isEmpty ? LayoutBuilder(
                              builder: (ctc,constraint){
                              return Column(
                  children: [
                    Container(height: constraint.maxHeight*(isLandscape ? 0.12 : 0.08),child: Text('No Transactions Added Yet',style: Theme.of(context).textTheme.headline6)),//Added Container To Give Height To This One
                    SizedBox(height: constraint.maxHeight*(isLandscape ? 0.05 : 0.06),),//we should calculate dynamically this
                    Container(height: constraint.maxHeight*(isLandscape ? 0.4 : 0.6),
                    child: Image.asset('assets/images/waiting.png',
                     fit: BoxFit.cover,)),
                  ],
                );}
              ) : ListView(children: //We Want A Single Widget In Children.So, Either USe Spread Operator Or Remove [] Brackets
                transactions.map((tx) => TransactionItem(
                  key: ValueKey(tx.id),//UniqueKey(), It Is Not great if this rebuilds constantly
                  transaction: tx, deleteTransaction: deleteTransaction)
                ).toList()
              );//ListView.builder(//Commented this Due to Bug
                //itemBuilder: (tx, index) {
                  /*return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);*//*Card(elevation: 5,
                  child: Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                    decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor,width: 2),),
                    child: Text('\$${transactions[index].amount.toStringAsFixed(2)}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColorDark),),
                    padding: EdgeInsets.all(10),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(transactions[index].title,style: Theme.of(context).textTheme.title/*TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red)*/,),
                ADate(transactions[index].date),//You Can Use DateFormat('yyyy-MM-dd').format(tx.date)
                ],
                ),
                ],
                ),
                );//Row*/
              //},
                //itemCount: transactions.length,
      //);
    //);
  }
}
//I Have Used Date Separately so not included intl.dart