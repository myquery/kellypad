import 'package:flutter/material.dart';

class MyStock extends StatelessWidget{
  MyStock({Key key, this.title, this.name, this.section}): super(key: key);

  final String title;
  final String name;
   final String section;



@override
Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title+" - "+ section),
      ),
      body: Text(name ),
    );
  }
}