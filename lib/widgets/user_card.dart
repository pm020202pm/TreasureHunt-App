import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'button.dart';
class UserCard extends StatefulWidget {
  UserCard({Key? key, required this.name, required this.deleteId}) : super(key: key);
  final String name;
  final String deleteId;
  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isDisqualify = true;

  void warningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          content: SizedBox(
            height: 90,
            child: Column(
              children: [
                const Text('Warning', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                const SizedBox(height: 30,),
                Text( (isDisqualify)? 'Are sure to disqualify ${widget.name.toUpperCase()} ?' : 'Are sure to send ${widget.name.toUpperCase()} to ${list[index+1].toUpperCase()} ?' , style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.grey[600]),),
              ],
            ),
          ),
          actions: [
            Button(buttonText: 'NO', textColor: Colors.grey[900], buttonBgColor: Colors.grey[200], onPressed: () { Navigator.pop(context); }, height: 35, width: 90, borderRadius: 15,),
            Button(
              buttonText: 'YES',
              textColor: Colors.green[800],
              buttonBgColor: Colors.green[100],
              onPressed: () async {
                await FirebaseFirestore.instance.collection((isDisqualify)? 'disqualify' : list[index+1]).add({'name': widget.name,});
                await FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete();
                // (isDisqualify)? disqualify() : updateLevel();
                Navigator.pop(context);
                },
              height: 35, width: 90, borderRadius: 15,
            ),
          ],
        );
      },
    );
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
                        if(userName ==value || userName==cordi)Button(buttonText: '  Send to\nnext venue', textColor: Colors.green[700], buttonBgColor: Colors.green[100], onPressed: () { setState(() { isDisqualify = false;}); warningDialog(); }, height: 38, width: 100, borderRadius: 15,),
                        const SizedBox(width: 10,),
                        if(userName==cordi)Button(buttonText: 'Disqualify', textColor: Colors.red[700], buttonBgColor: Colors.red[100], onPressed: () { setState(() {isDisqualify = true;});warningDialog();}, height: 38, width: 74, borderRadius: 15,),
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
