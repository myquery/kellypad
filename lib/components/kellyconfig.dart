import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import '../manager/page_switch.dart';

class KellyInkWell extends StatefulWidget {
  final String sectionTitle;

  

  KellyInkWell({this.sectionTitle});
  @override
  _KellyInkWellState createState() {
    // TODO: implement createState
    return _KellyInkWellState();
  }


}

class _KellyInkWellState extends State<KellyInkWell> {
  TextEditingController items = TextEditingController();
  int itemLevel;
  //List sectionItems = ['Sales', 'Expenses', 'Inventory'];

  Stream<QuerySnapshot> itemdoc =  Firestore.instance.collection('itemcollector').where('closingStock').snapshots();
 

  String section = 'Sales';
  String result;


   returnSectionTag(){
     setState(() {
        if(widget.sectionTitle == "Club Bar"){
      itemLevel = 1;
      
    }else if(widget.sectionTitle == "VIP Bar"){
      itemLevel = 2;
    }else if(widget.sectionTitle == 'Outside Bar'){
      itemLevel = 3;

    }else if(widget.sectionTitle == "Barbeque Spot"){
      itemLevel = 4;
    }else if(widget.sectionTitle == "Shawama/PopCorn"){
      itemLevel = 5;
    }else if(widget.sectionTitle == "Suya Spot"){
      itemLevel = 6;
    }else if(widget.sectionTitle == "Resturant"){
      itemLevel = 7;
    }else if(widget.sectionTitle == "Smoothie/Juice"){
      itemLevel = 8;
    }else{
      itemLevel = 0;
    }
       
     });
   
    

  }

    @override
  initState() {

    super.initState();
  }


changeItem(String item){
  setState(() {
   this.section = item;
  });
  
}

getItemsFromStore(){
  
}
  addItemRecord(){
      returnSectionTag();
 
  
    DocumentReference addItem = Firestore.instance.collection('itemcollector').document(); 
    Map<String, dynamic> deptitem = {
      'itemName': items.text,
      'itemLevel' : itemLevel
    };
    addItem.setData(deptitem);
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text(widget.sectionTitle),
                //content: Text('random text'),
                content: Container(
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          value:section,
                          isExpanded : true,
                          hint: Text("Choose Category"),
                        
                          items: <String>['Sales', 'Expenses', 'Stock']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                            onChanged: (String newValue) {
                           changeItem(newValue);
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Add Item to ${widget.sectionTitle}',
                            contentPadding:
                                EdgeInsets.only(top: -20.0, bottom: 2.0),
                          ),
                          controller: items,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        RaisedButton(
                          onPressed: () {
                            addItemRecord();
                          },
                          child: Text('Add Item'),
                        )
                      ],
                    )));
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}



