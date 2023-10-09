
import 'package:flutter/cupertino.dart';

import '../constants.dart';

// class Counter with ChangeNotifier{
//   String _count = "";
//   String get count => _count;
//   Future<void> number(String collection) async {
//     String num = await getDocumentCount(collection);
//     _count =num ;
//     notifyListeners();
//   }
// }
class Value with ChangeNotifier{
  String _val = 'teams';
  String get val => _val;
  void changeVal(){
    _val = value;
    notifyListeners();
  }
}