import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/bottom_button.dart';
import '../components/listkelly.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ],
      ),

      body: ListKelly(),
      bottomNavigationBar: makeBottom,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
