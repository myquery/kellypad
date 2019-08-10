// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AlertDialogItem extends StatefulWidget{

//    final String sectionID;

//    AlertDialogItem({this.sectionID});
//   _AlertDialogItemState createState(){
//     return _AlertDialogItemState();
//   }
// }

// class _AlertDialogItemState extends State<AlertDialogItem>{
//   TextEditingController items = TextEditingController();
//   int itemLevel;


//   String section = 'Sales';

//      returnSectionTag(){
//      setState(() {
//         if(widget.sectionID == "Club Bar"){
//       itemLevel = 1;
      
//     }else if(widget.sectionID == "VIP Bar"){
//       itemLevel = 2;
//     }else if(widget.sectionID == 'Outside Bar'){
//       itemLevel = 3;

//     }else if(widget.sectionID == "Barbeque Spot"){
//       itemLevel = 4;
//     }else if(widget.sectionID == "Shawama/PopCorn"){
//       itemLevel = 5;
//     }else if(widget.sectionID == "Suya Spot"){
//       itemLevel = 6;
//     }else if(widget.sectionID == "Resturant"){
//       itemLevel = 7;
//     }else if(widget.sectionID == "Smoothie/Juice"){
//       itemLevel = 8;
//     }else{
//       itemLevel = 0;
//     }
       
//      });
   
    

//   }

//     addItemRecord(){
//       returnSectionTag();
 
  
//     DocumentReference addItem = Firestore.instance.collection('itemcollector').document(); 
//     Map<String, dynamic> deptitem = {
//       'itemName': items.text,
//       'itemLevel' : itemLevel
//     };
//     addItem.setData(deptitem);
//   }

//   changeItem(String item){
//   setState(() {
//    this.section = item;
//   });
  
// }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return InkWell(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return StatefulBuilder(
//               builder: (context, setState){

//                  return AlertDialog(
//                 title: Text(widget.sectionID),
//                 //content: Text('random text'),
//                 content: Container(
//                     height: 150.0,
//                     child: Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           value:section,
//                           isExpanded : true,
//                           hint: Text("Choose Category"),
                        
//                           items: <String>['Sales', 'Expenses', 'Stock']
//                               .map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                                 value: value, child: Text(value));
//                           }).toList(),
//                             onChanged: (String newValue) {
//                            changeItem(newValue);
//                           },
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         TextField(
//                           decoration: InputDecoration(
//                             labelText: 'Add Item to ${widget.sectionID}',
//                             contentPadding:
//                                 EdgeInsets.only(top: -20.0, bottom: 2.0),
//                           ),
//                           controller: items,
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         RaisedButton(
//                           onPressed: () {
//                             addItemRecord();
//                           },
//                           child: Text('Add Item'),
//                         )
//                       ],
//                     )));

//               },
//             );
           
//           },
//         );
//       },
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Icon(Icons.more_vert),
//       ),
//     );
//   }

// }

import 'package:flutter/material.dart';



void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return new MaterialApp(

      title: 'Flutter Demo',

      theme: new ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: new MyHomePage(title: 'Flutter Demo Home Page'),

    );

  }

}



class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;



  @override

  _MyHomePageState createState() => new _MyHomePageState();

}



class _MyHomePageState extends State<MyHomePage> {

  String _selectedId;



  @override

  Widget build(BuildContext context) {

    return new Scaffold(

        appBar: new AppBar(

          title: const Text("Test"),

        ),

        body: new ListView(padding: const EdgeInsets.all(32.0), children: [

          new Container(

              padding: const EdgeInsets.all(10.0),

              child: new DropdownButton<String>(

                hint: const Text("Pick a thing"),

                value: _selectedId,

                onChanged: (String value) {

                  setState(() {

                    _selectedId = value;

                  });

                },

                items:

                    <String>['One', 'Two', 'Three', 'Four'].map((String value) {

                  return new DropdownMenuItem<String>(

                    value: value,

                    child: new Text(value),

                  );

                }).toList(),

              )),

        ]),

        floatingActionButton: new FloatingActionButton(

          child: new Icon(Icons.add),

          tooltip: "New Dialog",

          onPressed: () {

            showDialog(

                context: context,

                child: new MyDialog(

                  onValueChange: _onValueChange,

                  initialValue: _selectedId,

                ));

          },

        ));

  }



  void _onValueChange(String value) {

    setState(() {

      _selectedId = value;

    });

  }

}



class MyDialog extends StatefulWidget {

  const MyDialog({this.onValueChange, this.initialValue});



  final String initialValue;

  final void Function(String) onValueChange;



  @override

  State createState() => new MyDialogState();

}



class MyDialogState extends State<MyDialog> {

  String _selectedId;



  @override

  void initState() {

    super.initState();

    _selectedId = widget.initialValue;

  }



  Widget build(BuildContext context) {

    return new SimpleDialog(

      title: new Text("New Dialog"),

      children: <Widget>[

        new Container(

            padding: const EdgeInsets.all(10.0),

            child: new DropdownButton<String>(

              hint: const Text("Pick a thing"),

              value: _selectedId,

              onChanged: (String value) {

                setState(() {

                  _selectedId = value;

                });

                widget.onValueChange(value);

              },

              items: <String>['One', 'Two', 'Three', 'Four'].map((String value) {

                return new DropdownMenuItem<String>(

                  value: value,

                  child: new Text(value),

                );

              }).toList(),

            )),

      ],

    );

  }

}