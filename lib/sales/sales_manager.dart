import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  //List _items;

  int sotckLevel;
  int stockPrice;
  String stockName;

  String doc;

  Map<String, dynamic> items;
  String section;
  int itemLevel;

final now = DateTime.now();
 //final yesterday = DateTime(now.year, now.month, now.day - 1);

  //form variables

  String _totalStock;

  FireService fireService = new FireService();

  // StockManager stock = new SalesManager()

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


getLastOpeningStock(stock) async {
 final QuerySnapshot result = await Firestore.instance
        .collection('itemcollector')
        .where('itemName', isEqualTo: doc)
        .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;
}
  getDoc(doc) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('itemcollector')
        .where('itemName', isEqualTo: doc)
        .getDocuments();

    final List<DocumentSnapshot> documents = result.documents;

    documents.forEach((f) {
      if (doc == f.data['itemName']) {
        //initial value for item selected
        unitPrice.text = f.data['itemPrice'];
        //Firestore.instance.collection(path)
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
    if (widget.section == "Club Bar") {
      itemLevel = 1;
    } else if (widget.section == "VIP Bar") {
      itemLevel = 2;
    } else if (widget.section == "Outside Bar") {
      itemLevel = 3;
    } else if (widget.section == "Barbeque Spot") {
      itemLevel = 4;
    } else if (widget.section == "Shawama/PopCorn") {
      itemLevel = 5;
    } else if (widget.section == "Suya Spot") {
      itemLevel = 6;
    } else if (widget.section == "Resturant") {
      itemLevel = 7;
    } else if (widget.section == "Smoothie/Juice") {
      itemLevel = 8;
    } else {
      itemLevel = 0;
    }

    super.initState();
    setState(() {
      //getDoc();
      fireService.getData().then((value) {
        print(value);
      });
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
                          Text(stockPrice.toString()),
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
                                  setState(() {
                                    section = val;
                                    getDoc(section);
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
                             onTap: (){
                               print(openingStock.text);
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
                            ),
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
