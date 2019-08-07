import 'package:flutter/material.dart';


import 'homescreen/home.dart';

void main() => runApp(KellyPad());

class KellyPad extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KellyPad',
      
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      home: MyHomePage(
        title: 'KellyPad',
       
      ),
    );
  }
}