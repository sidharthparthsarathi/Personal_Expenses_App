import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adaptive_flat_button.dart';
import 'package:intl/intl.dart';
class NewTransactions extends StatefulWidget {//convert stateless to stateful widget
    final Function addnewTransaction;
    NewTransactions(this.addnewTransaction){
      //print("Constructor New Transaction Widget");
    }

  @override
  _NewTransactionsState createState() {
    //print('CreateState New Transaction Widget');
    return _NewTransactionsState();
  }
}

class _NewTransactionsState extends State<NewTransactions> {
    final titleInput=TextEditingController();
    final amount=TextEditingController();
    DateTime selectedDate;
    _NewTransactionsState()
    {
      //print('Constructor New Transaction State');
    }
    @override
  void initState() {
    //print('initState()');
    super.initState();
  }
  @override
  void didUpdateWidget(NewTransactions oldWidget) {
    //print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    //print('Dispose()');
    super.dispose();
  }

    void submitData()
    {
      if(amount.text.isEmpty)
      {
        return;
      }
      final enteredInput=titleInput.text;
      final enteredAmount=double.parse(amount.text);
      if(enteredInput.isEmpty||enteredAmount<=0||selectedDate==null)//||enteredAmount.toString().isEmpty) we cant use double for .isEmpty
      {
        return;
      }
                widget.addnewTransaction(//widget is a special property that gives us access to the widget class 
                  enteredInput,
                  enteredAmount,
                  selectedDate,
                );
    Navigator.of(context).pop();//pop method is used to close the topmost screen(New transaction Here),Context gives us access to the context of the widget
    }
    void datePicker(){
      showDatePicker(
        context: context,
         initialDate: DateTime.now(),
          firstDate: DateTime(2019),
           lastDate: DateTime.now()).then((pickedDate){
             if(pickedDate==null)
                    return;
             setState(() {
               selectedDate=pickedDate;
             });
           });
    }

  @override
  Widget build(BuildContext context) {
    //print('Build() New Transactions.');
        print(MediaQuery.of(context).viewInsets);
    return SingleChildScrollView(
          child: Card(elevation: 6,child: Container(padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [TextField(decoration: const InputDecoration(labelText: 'title'),//using const to avoid performance drop
          controller: titleInput,
          onSubmitted: (_) => submitData(),
          /*onChanged: (val) => titleInput=val,*/
          ),
          TextField(decoration: const InputDecoration(labelText: 'Amount'),//using const to avoid performance drop
          //onChanged: (val) {
            //amount=val;
            //},
            controller: amount,
            keyboardType: TextInputType.number,//to get a keyboard of number
            onSubmitted: (_) => submitData(),
          ),
          Container(
            height: 70,
            child: Row(children: [
              Expanded(
                            child: Text(
                  selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                ),
              ),
              AdaptiveFlatButton(datePicker,'Choose Date'),
            ],),
          ),
          /*FlatButton*/RaisedButton(onPressed: submitData,//use pointer of function//() => submitData(),//we can use anonymous function here
           child: const Text('Add Transaction',),
           color: Theme.of(context).primaryColor,
           textColor: Theme.of(context).textTheme.button.color,),
          ],
        ),
        ),
        ),
    );
  }
}