import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class ChartBar extends StatelessWidget {
  final String label;
  final double spendingOfTotal;
  final double spendingPctOfTotal;
  ChartBar(this.label,this.spendingOfTotal,this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    //print('Build() ChartBar');
    return LayoutBuilder(
          builder: (ctx, constraints){
            return Column(
        children: [
          Container(height: constraints.maxHeight*0.15,
          child: FittedBox(child: Text('\$${spendingOfTotal.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(
            height: constraints.maxHeight*0.6,
            width: 10,//constraints.maxWidth*0.1, you can use this
            child: Stack(children: [
              Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0),
              color: Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
              ),
              ),
              FractionallySizedBox(heightFactor: spendingPctOfTotal,
              child: Container(decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),),
              ),
            ],)
          ),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(height: constraints.maxHeight*0.15,child: FittedBox(child: Text(label),),),//we can use Text('$label')
        ],
      );
          }
    );
  }
}