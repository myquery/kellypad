import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../manager/viewrecord/view_sales.dart';
import '../manager/model/sales_model.dart';

import '../homescreen/home.dart';
import '../stock_manager.dart';

class SalesManager extends StatefulWidget {
  SalesManager({Key key, this.section}) : super(key: key);
  String section;

  @override
  _StateManagerState createState() {
    // TODO: implement createState
    return _StateManagerState();
  }
}

class _StateManagerState extends State<SalesManager> {
  final List<String> sectionCat = List<String>();
  List _items;

  Map<String, dynamic> items;
  String section;

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



  @override
  initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

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
                                  });
                                },
                                hint: Text("Select Item"),
                                isExpanded: true,
                              );
                            },
                          ),

                          SizedBox(height:15.0),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Add Opening Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
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
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Total Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: totalStock,
                              keyboardType: TextInputType.number,
                            ),
                          ),
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
                                    //if (_formKey.currentState.validate()) {
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
                      
                                      DocumentReference dsstock = Firestore
                                          .instance
                                          .collection('club')
                                          .document();

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
                                    //}
                                  },
                                  child: Text('Submit Report'),
                                )
                              ]))
                        ],
                      ),
                    )))));
  }
}
