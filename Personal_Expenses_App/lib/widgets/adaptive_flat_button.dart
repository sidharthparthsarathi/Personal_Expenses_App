import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AdaptiveFlatButton extends StatelessWidget {
  final Function datePicker;
  final String text;
  AdaptiveFlatButton(this.datePicker,this.text);
  @override
  Widget build(BuildContext context) {
    print('Build() AdaptiveFlatButton');
    return Platform.isIOS ? CupertinoButton(
                //color: Colors.blue,
                child: Text(text,
                style: const TextStyle(fontWeight: FontWeight.bold,//using const to avoid performance drop
                ),
                ),
                onPressed: datePicker,
              )
               : FlatButton(onPressed: datePicker, child: Text(text,style: const TextStyle(fontWeight: FontWeight.bold//using const to avoid performance drop
               ),
               ),
              textColor: Theme.of(context).primaryColor,);
  }
}