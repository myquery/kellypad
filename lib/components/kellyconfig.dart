import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import '../manager/page_switch.dart';

class KellyInkWell extends StatefulWidget {
  final String sectionTitle;
  String selectedID;

  KellyInkWell({this.sectionTitle, this.selectedID});
  @override
  _KellyInkWellState createState() {
    // TODO: implement createState
    return _KellyInkWellState();
  }
}

class _KellyInkWellState extends State<KellyInkWell> {
  // TextEditingController items = TextEditingController();
  // int itemLevel;
  //List sectionItems = ['Sales', 'Expenses', 'Inventory'];

  Stream<QuerySnapshot> itemdoc =
      Firestore.instance.collection('itemcollector').snapshots();

  String section = 'Sales';
  String result = '';



  @override
  initState() {
    super.initState();
  }



  void _onValueChange(String value) {
    setState(() {
      section = value;
    });
  }

  getItemsFromStore() {}


  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          child: MyDialog(initialValue: section, onValueChange: _onValueChange, sectionTitle: widget.sectionTitle,),
         
        );
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({this.onValueChange, this.initialValue, this.sectionTitle});

  final String initialValue;
  final String sectionTitle;

  final void Function(String) onValueChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  String _selectedId;
  TextEditingController items = TextEditingController();
  TextEditingController itemprice = TextEditingController();
  int itemLevel;

   returnSectionTag() {
    setState(() {
      if (widget.sectionTitle == "Club Bar") {
        itemLevel = 1;
      } else if (widget.sectionTitle == "VIP Bar") {
        itemLevel = 2;
      } else if (widget.sectionTitle == 'Outside Bar') {
        itemLevel = 3;
      } else if (widget.sectionTitle == "Barbeque Spot") {
        itemLevel = 4;
      } else if (widget.sectionTitle == "Shawama/PopCorn") {
        itemLevel = 5;
      } else if (widget.sectionTitle == "Suya Spot") {
        itemLevel = 6;
      } else if (widget.sectionTitle == "Resturant") {
        itemLevel = 7;
      } else if (widget.sectionTitle == "Smoothie/Juice") {
        itemLevel = 8;
      } else {
        itemLevel = 0;
      }
    });
  }

  addItemRecord() {
    returnSectionTag();

    DocumentReference addItem =
        Firestore.instance.collection('itemcollector').document();
    Map<String, dynamic> deptitem = {
      'itemName': items.text,
      'itemPrice' : itemprice.text,
      'itemLevel': itemLevel
    };
    addItem.setData(deptitem);
  }
  @override
  void initState() {
    super.initState();

    _selectedId = widget.initialValue;
  }

   changeItem(item) {
    setState(() {
      _selectedId = item;
    });
  }

  Widget build(BuildContext context) {
    return AlertDialog(
                title: Text(widget.sectionTitle),
                //content: Text('random text'),
                content: Container(
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          value: _selectedId,
                          isExpanded: true,
                          hint: Text("Choose Item"),
                          onChanged: (String newValue) {
                            changeItem(newValue);
                          },
                          items: <String>['Sales', 'Expenses', 'Stock']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
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
  }
}
