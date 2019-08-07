import 'package:flutter/material.dart';
//import '../kellypad_sections.dart';

import '../manager/sales.dart';
import '../manager/expenses.dart';
import '../manager/stock.dart';

import '../manager/viewrecord/view_sales.dart';

class KellyTile extends StatefulWidget {
//final tileKey = new LocalKey<>()

  KellyTile({Key key, this.tileName, this.sections}) : super(key: key);

  final String tileName;
  final String sections;

  @override
  _MyKellyTIileState createState() {
    // TODO: implement createState
    return _MyKellyTIileState();
  }
}

class _MyKellyTIileState extends State<KellyTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ViewSalesReport(title: "Manage Sales",  name: widget.tileName, section: widget.sections)
                
                  // MySales(
                  //     title: "Manage Sales",
                  //     name: widget.tileName,
                  //     section: widget.sections),
                ));
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Sales"),
          ),
        ),
        SizedBox(width: 20.0),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyExpenses(
                      title: "Manage Expenses",
                      name: widget.tileName,
                      section: widget.sections),
                ));
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Expenses"),
          ),
        ),
        SizedBox(width: 20.0),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // print(key);
                        ViewSalesReport(title: "Manage Stock",  name: widget.tileName, section: widget.sections)
                    //MyStock(title: "Manage Stock",  name: widget.tileName, section: widget.sections ),

                    ));
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Stock"),
          ),
        ),
      ],
    );
  }
}
