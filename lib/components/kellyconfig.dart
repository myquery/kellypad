import "package:flutter/material.dart";

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
  String section = 'Sales';

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text(widget.sectionTitle),
                //content: Text('random text'),
                content: Container(
                    height: 150.0,
                    child: Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          value: section,
                          onChanged: (String newValue) {
                            setState(() {
                              section = newValue;
                            });
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
                            print(items);
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
