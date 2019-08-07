import 'package:flutter/material.dart';

import '../components/kellytile.dart';
import '../components/kellyconfig.dart';

class ListKelly extends StatefulWidget {
  ListKelly({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ListKellyState createState() {
    // TODO: implement createState
    return _ListKellyState();
  }
}

class _ListKellyState extends State<ListKelly> {
  final List<String> dept = [
    "Club Bar",
    "VIP Bar",
    "Outside Bar",
    "Barbeque Spot",
    "Shawama/PopCorn",
    "Suya Spot",
    "Resturant",
    "Smoothie/Juice"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          // key: ValueKey(context),
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[0],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName :'club', sections: dept[0], ),

          trailing: KellyInkWell(sectionTitle:dept[0],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[1],
                style: new TextStyle(fontWeight: FontWeight.bold),),
          ),

          subtitle: KellyTile(tileName:'vip', sections: dept[1]),
          trailing: KellyInkWell(sectionTitle:dept[1],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[2],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName: 'outbar', sections: dept[2]),
          trailing: KellyInkWell(sectionTitle:dept[2],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[3],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName:'bbq', sections: dept[3]),
          trailing: KellyInkWell(sectionTitle:dept[3],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[4],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName:'shawama', sections: dept[4]),
          trailing: KellyInkWell(sectionTitle:dept[4],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[5],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName:'suya', sections: dept[5]),
          trailing: KellyInkWell(sectionTitle:dept[5],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[6],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName:'resturant', sections: dept[6]),
          trailing: KellyInkWell(sectionTitle:dept[6],),

          //   onTap: () {
          //   print(null);
          // },
        ),
        ListTile(
          title: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(dept[7],
                style: new TextStyle(fontWeight: FontWeight.bold)),
          ),

          subtitle: KellyTile(tileName:'smoothie', sections: dept[7]),
          trailing: KellyInkWell(sectionTitle:dept[7],) ,

          //   onTap: () {
          //   print(null);
          // },
        ),
      ]).toList(),
      //SizedBox(height: 50.0);
    );
  }
}
