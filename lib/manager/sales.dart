import 'package:flutter/material.dart';
import '../sales/sales_manager.dart';

class MySales extends StatelessWidget{
  MySales({Key key, this.title, this.name, this.section}): super(key: key);

  final String title;
  final String name;
  final String section;

  


@override
Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(title +" - "+ section),
      ),
      resizeToAvoidBottomInset: false,
      body:SalesManager(section: section),
    );
  }
}