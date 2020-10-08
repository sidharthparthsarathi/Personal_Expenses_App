import 'dart:math';
import 'package:flutter/material.dart';
import '../Models/Transactions.dart';
import '../Date.dart';
class TransactionItem extends StatefulWidget {
   final Transaction transaction;
  final Function deleteTransaction;
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color bgColor;
  @override
  void initState() {
    const availableColors=[Colors.blue,Colors.green,Colors.yellow];
    bgColor=availableColors[Random().nextInt(3)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(elevation: 8,
                        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),//using const to avoid performance drop
                        child: ListTile(leading: CircleAvatar(backgroundColor: bgColor,
                          radius: 30,child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(child: Text('\$${widget.transaction.amount}',style: Theme.of(context).textTheme.headline6,),
                          ),
                          ),
                          ),
                          title: Text('${widget.transaction.title}'),
                          subtitle: ADate(widget.transaction.date),
                          trailing: MediaQuery.of(context).size.width > 480 ? FlatButton.icon(onPressed: () => widget.deleteTransaction(widget.transaction.id),
                          icon: Icon(Icons.delete),
                          label: const Text('Delete'),//using const to avoid performance drop
                          textColor: Theme.of(context).errorColor)
                          : IconButton(
                            icon: Icon(
                              Icons.delete),
                               onPressed: () => widget.deleteTransaction(
                                 widget.transaction.id),
                                 color: Theme.of(context).errorColor,
                                 ),
      ),
    );
  }
}