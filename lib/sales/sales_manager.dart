import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../manager/viewrecord/view_sales.dart';
import '../manager/model/sales_model.dart';

import '../homescreen/home.dart';

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

    // item = TextEditingController();
    // openingStock = TextEditingController();
    // addedStock = TextEditingController();
    // totalStock = TextEditingController();
    // soldStock = TextEditingController();
    // unitPrice = TextEditingController();
    // spoilage = TextEditingController();
    // complementary = TextEditingController();
    // itemDiscount = TextEditingController();
    // closingStock = TextEditingController();
    // totalAmount = TextEditingController();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Add Sales to: ${widget.section}")),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
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
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Add Item',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: item,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Add Opening Stock',
                                contentPadding:
                                    EdgeInsets.only(top: -20.0, bottom: 2.0),
                              ),
                              controller: openingStock,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSalesReport(),
                                        ));
                                  },
                                  child: Text('View Report'),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    // Firestore.instance.runTransaction((Transaction transaction) async {
                                    //   await transaction.update(Firestore.instance.collection('club').document(), {
                                    //     'item': item,
                                    //     'openingstock': openingStock.text,
                                    //     'addedstock': addedStock,
                                    //     'totalstock' : totalStock,
                                    //     'soldstock' : soldStock,
                                    //     'unitprice' : unitPrice,
                                    //     'spoilage': spoilage,
                                    //     'complementary': complementary,
                                    //     'itemdiscount': itemDiscount,
                                    //     'closingStock': closingStock,
                                    //     'totalamount': totalAmount
                                    //   });

                                    // });
                                    DocumentReference dsstock = Firestore
                                        .instance
                                        .collection('club')
                                        .document();
                              
                                    Map<String, dynamic> stock = {
                                      'item': item.text,
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
                                    dsstock
                                        .setData(stock)
                                        .whenComplete(() {
                                      print("Stock Added...");
                                    }).catchError((e) {
                                      print(e);
                                    });
                                  },
                                  child: Text('Submit Report'),
                                )
                              ]))
                        ],
                      ),
                    )))));
  }
}
