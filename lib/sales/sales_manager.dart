import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../manager/viewrecord/view_sales.dart';
import '../manager/model/sales_model.dart';

import '../homescreen/home.dart';
import '../service.dart';

class SalesManager extends StatefulWidget {
  SalesManager({Key key, this.section}) : super(key: key);
  final String section;

  @override
  _StateManagerState createState() {
    // TODO: implement createState
    return _StateManagerState();
  }
}

class _StateManagerState extends State<SalesManager> {
  final List<String> sectionCat = List<String>();

  QuerySnapshot result;

  int stockPrice;
  String stockName;

  String doc;

  String department;

  Map<String, dynamic> items;
  String section;
  int itemLevel;

  //bool _validate = false;

  final now = DateTime.now();
  var _focusNode = new FocusNode();
  var nodeComplement = new FocusNode();
  //final yesterday = DateTime(now.year, now.month, now.day - 1);

  //form variables

  TextEditingController item = TextEditingController();
  TextEditingController openingStock = TextEditingController();
  TextEditingController addedStock = TextEditingController();
  TextEditingController totalStock = TextEditingController();
  TextEditingController soldStock = TextEditingController();
  TextEditingController unitPrice = TextEditingController();
  TextEditingController spoilage = TextEditingController();
  TextEditingController complementary = TextEditingController();
  TextEditingController itemDiscount = TextEditingController();
  TextEditingController closingStock = TextEditingController();
  TextEditingController totalAmount = TextEditingController();

//method to get the price of item selected
  DateTime yesterday;
  getLastClosingStock(stock, collection) async {
    result = await Firestore.instance
        .collection(collection)
        .where('item', isEqualTo: stock)
        .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;
    documents.forEach((f) {
      openingStock.text = f.data['closingStock'];
    });
  }

  getDoc(doc) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('itemcollector')
        .where('itemName', isEqualTo: doc)
        .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((f) {
      if (doc == f.data['itemName']) {
        //return
        //initial value for item selected
        unitPrice.text = f.data['itemPrice'];
      }
    });
  }

// getDate(){
// final now = DateTime.now();
// final today = DateTime(now.year, now.month, now.day);
// final yesterday = DateTime(now.year, now.month, now.day - 1);
// final tomorrow = DateTime(now.year, now.month, now.day + 1);

// final aDateTime = ...
// final aDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
// if(aDate == today) {
//   ...
// } else (aDate == yesterday) {
//   ...
// } else (aDate == tomorrow) {
//   ...
// }
// }

// getTotalStock(){
//  totalStock.text = openingStock.text + addedStock.text;
// }

// getTotalStock(){

// }
  @override
  initState() {
    print(now.subtract(Duration(days: 3)));
    print(now.day - 1);
    if (widget.section == "Club Bar") {
      itemLevel = 1;
      department = "club";
    } else if (widget.section == "VIP Bar") {
      itemLevel = 2;
      department = "vip";
    } else if (widget.section == "Outside Bar") {
      itemLevel = 3;
      department = "outbar";
    } else if (widget.section == "Barbeque Spot") {
      itemLevel = 4;
      department = "bbq";
    } else if (widget.section == "Shawama/PopCorn") {
      itemLevel = 5;
      department = "shawama";
    } else if (widget.section == "Suya Spot") {
      itemLevel = 6;
      department = "suya";
    } else if (widget.section == "Resturant") {
      itemLevel = 7;
      department = "resturant";
    } else if (widget.section == "Smoothie/Juice") {
      itemLevel = 8;
      department = "smoothie";
    } else {
      itemLevel = 0;
    }

    super.initState();
    setState(() {
      yesterday = DateTime(now.year, now.month, now.day - 1);
      print(yesterday);
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField has lost focus
        var sold = int.parse(soldStock.text).toInt();
        var price = int.parse(unitPrice.text).toInt();
        var total = sold * price;
        totalAmount.text = total.toString();
      }
    });
    nodeComplement.addListener((){
        var spoil = int.parse(spoilage.text).toInt();
        var complement = int.parse(complementary.text).toInt();
         var sold = int.parse(soldStock.text).toInt();
        var total = spoil + complement + sold;
        closingStock.text = total.toString();
    });
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DocumentReference dsstock;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    //int _totalstock = openingStock + addedStock;
    // TODO: implement build

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Add Sales to: ${widget.section}")),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                autovalidate: true,
                child: Card(
                    elevation: 2.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15.0,
                          ),
                          //Text(stockPrice.toString()),
                          Text('Add Daily Sales of ${widget.section}',
                              style:
                                  new TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(height: 10.0),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('itemcollector')
                                .where('itemLevel', isEqualTo: itemLevel)
                                .orderBy('itemName', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Please wait...");
                              }

                              return DropdownButton(
                                items: snapshot.data.documents
                                    .map((DocumentSnapshot documentSnapshot) {
                                  //section = documentSnapshot.data['itemName'];
                                  return DropdownMenuItem(
                                    child:
                                        Text(documentSnapshot.data['itemName']),
                                    value: documentSnapshot.data['itemName'],
                                  );
                                }).toList(),
                                value: section,
                                onChanged: (val) {
                                  // Center(
                                  //     child: SizedBox(
                                  //       child: CircularProgressIndicator(),
                                  //       height: 20.0,
                                  //       width: 20.0,
                                  // ));
                                  //getLastClosingStock(val, widget.section);
                                  setState(() {
                                    section = val;
                                    getDoc(section);
                                    getLastClosingStock(section, department);
                                  });
                                },
                                hint: Text("Select Item"),
                                isExpanded: true,
                              );
                            },
                          ),
                          SizedBox(height: 15.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Add Opening Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 3.0),

                                //return
                              ),
                              controller: openingStock,
                              onSubmitted: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Added Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: addedStock,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Total Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: totalStock,
                              onTap: () {
                                var open = int.parse(openingStock.text).toInt();
                                var add = int.parse(addedStock.text).toInt();
                                var total = open + add;
                                totalStock.text = total.toString();
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Unit Price ',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: unitPrice,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                labelText: 'Sold Stock ',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: soldStock,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Total Spoilage',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: spoilage,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              focusNode: nodeComplement,
                              decoration: InputDecoration(
                                labelText: 'Total Complementary',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: complementary,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Total Discount',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: itemDiscount,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Total Closing Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: closingStock,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Total Amount Sold',
                                  contentPadding:
                                      EdgeInsets.only(top: -20.0, bottom: 2.0),
                                ),
                                controller: totalAmount,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  var sold = int.parse(soldStock.text).toInt();
                                  var price = int.parse(unitPrice.text).toInt();
                                  var total = sold * price;
                                  totalAmount.text = total.toString();
                                }),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('View Report'),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    // checkItem();
                                    // return;
                                    if (_formKey.currentState.validate()) {
                                      _scaffoldKey.currentState
                                          .showSnackBar(new SnackBar(
                                        duration: new Duration(seconds: 4),
                                        content: new Row(
                                          children: <Widget>[
                                            new CircularProgressIndicator(),
                                            new Text(" Adding Stock...")
                                          ],
                                        ),
                                      ));

                                      if (widget.section == "Club Bar") {
                                        dsstock = Firestore.instance
                                            .collection('club')
                                            .document();
                                      } else if (widget.section == "VIP Bar") {
                                        dsstock = Firestore.instance
                                            .collection('vip')
                                            .document();
                                      } else if (widget.section ==
                                          "Outside Bar") {
                                        dsstock = Firestore.instance
                                            .collection('outbar')
                                            .document();
                                      } else if (widget.section ==
                                          "Barbeque Spot") {
                                        dsstock = Firestore.instance
                                            .collection('bbq')
                                            .document();
                                      } else if (widget.section ==
                                          "Shawama/PopCorn") {
                                        dsstock = Firestore.instance
                                            .collection('shawama')
                                            .document();
                                      } else if (widget.section ==
                                          "Suya Spot") {
                                        dsstock = Firestore.instance
                                            .collection('suya')
                                            .document();
                                      } else if (widget.section ==
                                          "Resturant") {
                                        dsstock = Firestore.instance
                                            .collection('resturant')
                                            .document();
                                      } else if (widget.section ==
                                          "Smoothie/Juice") {
                                        dsstock = Firestore.instance
                                            .collection('smoothie')
                                            .document();
                                      } else {
                                        return null;
                                      }

                                      Map<String, dynamic> stock = {
                                        'item': section,
                                        'openingstock': openingStock.text,
                                        'addedstock': addedStock.text,
                                        'totalstock': totalStock.text,
                                        'soldstock': soldStock.text,
                                        'unitprice': unitPrice.text,
                                        'spoilage': spoilage.text,
                                        'complementary': complementary.text,
                                        'itemdiscount': itemDiscount.text,
                                        'closingStock': closingStock.text,
                                        'totalamount': totalAmount.text,
                                        'dateadded': now
                                      };
                                      //if (stock.length < 0) return;
                                      dsstock.setData(stock).whenComplete(() {
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: Text('Submit Report'),
                                )
                              ]))
                        ],
                      ),
                    )))));
  }
}
