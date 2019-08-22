import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';



class FireService {

   getData() async {
    return await Firestore.instance.collection('itemcollector').getDocuments();
    //notifyListeners();
  }
}