import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../sales/sales_manager.dart';

class ViewSalesReport extends StatelessWidget{
  //final String sectionName;
   ViewSalesReport({this.title, this.name, this.section});
  final String title;
  final String name;
  final String section;

  @override
  Widget build(BuildContext context){
    DateTime now = DateTime.now();
    var daily = now.weekday;


    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Report : ${section}"),
      ),
      body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),

      child: StreamBuilder<QuerySnapshot>(

        stream: Firestore.instance.collection('club').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.data == null)
            return LinearProgressIndicator();
            //return Text('Error: ${snapshot.error}');

            switch (snapshot.connectionState){
                case ConnectionState.waiting:
              return  Text('Loading...');
              
              default:
              return ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document){

                  //return Text(document.data['item']);
                    return Card(
                      elevation: 2.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                   
                      children: <Widget>[
                       Text(document.data['dateadded'].toString()),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Item:", style: Theme.of(context).textTheme.headline, ),
                            Text(document.data['item'], style:  Theme.of(context).textTheme.headline,),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Opening Stock:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['openingstock'].toString()),

                          ],
                        ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Added Stock:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['addedstock'].toString()),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Total Stock:", style: new TextStyle(fontWeight: FontWeight.bold), ),
                             Text(document.data['totalstock'].toString()),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Unit Price:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['unitprice'].toString()),

                          ],
                        ),
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Sold Stock", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['soldstock'].toString()),

                          ],
                        ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Damaged Stock:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['spoilage'].toString()),

                          ],
                        ),  
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Complementary:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['complementary'].toString()),

                          ],
                        ),  
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Discount:", style: new TextStyle(fontWeight: FontWeight.bold),),
                             Text(document.data['itemdiscount'].toString()),

                          ],
                        ),  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Closing Stock:", style: new TextStyle(fontWeight: FontWeight.bold),),
                             Text(document.data['closingStock'].toString()),

                          ],
                        ),   
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Total Amount Sold:", style: new TextStyle(fontWeight: FontWeight.bold),),
                            Text(document.data['totalamount'].toString()),

                          ],
                        ),                     
                        
                                            
                        ],

                      ),
                      )
                    );
                  }).toList()
               
              );
            }
        },
      )
       ),

       floatingActionButton: Padding(
         padding: const EdgeInsets.all(8.0),
         child: FloatingActionButton(
           onPressed: (){
             Navigator.push(context, 
             MaterialPageRoute(
               builder: (context) =>   SalesManager(section:section),
               )
             );
           },
           backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
           child: Icon(Icons.add,),
         ),
       ),
    );
  }


  
}