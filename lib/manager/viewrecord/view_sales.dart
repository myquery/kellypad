import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../sales/sales_manager.dart';
import '../page_switch.dart';

class ViewSalesReport extends StatefulWidget {
  //final String sectionName;
  ViewSalesReport({this.title, this.name, this.section});
  final String title;
  final String name;
  final String section;

@override
  _ViewSalesReportState createState() {
    // TODO: implement createState
    return _ViewSalesReportState();
  }

}
  
class _ViewSalesReportState extends State<ViewSalesReport>{

  String collections;
  @override
  initState() {

     if(widget.section == "Club Bar"){
     collections = 'club';
    }else if(widget.section == "VIP Bar"){
      collections = 'vip';
    }else if(widget.section == "Outside Bar"){
      collections = 'outbar';
    }else if(widget.section == "Barbeque Spot"){
      collections = 'bbq';
    }else if(widget.section == "Shawama/PopCorn" ){
      collections = 'shawama';
    }else if(widget.section == "Suya Spot"){
      collections = 'suya';
    }else if(widget.section == "Resturant"){
      collections = 'resturant';
    }else if(widget.section == "Smoothie/Juice"){
      collections = 'smoothie';
    }else{
      collections = "";
    }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // var daily = now.weekday;

    // PageSwitch pageroutes;
    // switch(){
    //   case pageroutes.:
    // }

    



    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report : ${widget.section}"),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection(collections)
                .orderBy('dateadded', descending: true )
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data == null)
                return Center(
                  child:SizedBox(
                    child:CircularProgressIndicator(),
                    height: 50.0,
                    width: 50.0,
                    )
                    );
              //return Text('Error: ${snapshotv.error}');
                
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');

                default:
                  return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                    //return Text(document.data['item']);
                    return Card(
                        elevation: 2.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Text(DateFormat.yMMMEd()
                                  .format(document.data['dateadded'])),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Item:",
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                  Text(
                                    document.data['item'],
                                    style: Theme.of(context).textTheme.headline,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Opening Stock:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      document.data['openingstock'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Added Stock:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['addedstock'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total Stock:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['totalstock'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Unit Price:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['unitprice'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Sold Stock",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['soldstock'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Damaged Stock:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['spoilage'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Complementary:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['complementary']
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Discount:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      document.data['itemdiscount'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Closing Stock:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      document.data['closingStock'].toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total Amount Sold:",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(document.data['totalamount'].toString()),
                                ],
                              ),
                            ],
                          ),
                        ));
                  }).toList());
              }
            },
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalesManager(section: widget.section),
                ));
          },
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
