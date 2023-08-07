import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../home_page.dart';
import 'button.dart';
class UserCard extends StatefulWidget {
  UserCard({Key? key, required this.name, required this.deleteId}) : super(key: key);
  final String name;
  final String deleteId;
  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {

  Future<void> updateLevel() async {
    await FirebaseFirestore.instance.collection(list[index+1]).add({
      'name': widget.name,
    }).then((value) => print("level updated")).catchError((error) => print("Failed to update level: $error"));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
    FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete().then((value) {
      print('CARD DELETED SUCCESSFULLY');
    }).catchError((error) {
      print('FAILED TO DELETE CARD: $error');
    });
  }
  void acceptDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.center,
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              const Text('Warning', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
              const SizedBox(height: 30,),
              Text('Are sure to disqualify ${widget.name.toUpperCase()} ?'),
              const Text('It is not reversible', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
            ],
          ),
        ),
        actions: [
          Button(buttonText: 'Cancel', textColor: Colors.grey[900], buttonBgColor: Colors.grey[200], onPressed: () { Navigator.pop(context); }, height: 35, width: 90, borderRadius: 15,),
          Button(buttonText: 'Disqualify', textColor: Colors.red[800], buttonBgColor: Colors.red[100], onPressed: () { disqualify(); }, height: 35, width: 90, borderRadius: 15,),
        ],
      );
    },
  );
}


  Future<void> disqualify() async {
    await FirebaseFirestore.instance.collection('disqualify').add({
      'name': widget.name,
    }).then((value) => print("disqualified")).catchError((error) => print("Failed to disqualify: $error"));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));

    FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete().then((value) {
      print('CARD DELETED SUCCESSFULLY');
    }).catchError((error) {
      print('FAILED TO DELETE CARD: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 5.0),
                  ),
                ],
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name.toUpperCase(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.grey[700]),),
                    Row(
                      children: [
                        if(userName ==value || userName==cordi)Button(buttonText: '  Send to\nnext venue', textColor: Colors.green[700], buttonBgColor: Colors.green[100], onPressed: () {updateLevel();  }, height: 38, width: 100, borderRadius: 15,),
                        const SizedBox(width: 10,),
                        if(userName==cordi)Button(buttonText: 'Disqualify', textColor: Colors.red[700], buttonBgColor: Colors.red[100], onPressed: () { acceptDialog();}, height: 38, width: 74, borderRadius: 15,),
                      ],
                    ),

                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
