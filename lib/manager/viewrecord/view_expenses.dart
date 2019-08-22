import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../service.dart';

class GetRecordsFromFirestore extends StatefulWidget{

  @override
  MyGetRecordsFromFirestore createState() {
    // TODO: implement createState
    return MyGetRecordsFromFirestore();
  }

}

class MyGetRecordsFromFirestore extends State<GetRecordsFromFirestore>{

//FireService fireData = new FireService();

List<String> myList;


getFireData(){
 var fireData =  Firestore.instance.collection('itemcollector').getDocuments();
    fireData.then((onValue){
      print(onValue);
    });
  
}

@override
void initState() {
    // TODO: implement initState
    setState(() {
      getFireData();
    });
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("view Expenses"),
      ),

      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Text("myList"),
            ],
          ),
        ),
      ) ,

    );
  }

}