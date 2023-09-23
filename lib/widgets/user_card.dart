import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class UserCard extends StatefulWidget {
  const UserCard({Key? key, required this.name, required this.deleteId}) : super(key: key);
  final String name;
  final String deleteId;
  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  String formattedTime = DateFormat.jm().format(DateTime.now());
  late String name = widget.name.toUpperCase();

  Future<void> addLog(String name) async {
    await FirebaseFirestore.instance.collection('log').add({'name':  name, 'time': formattedTime,});
  }
  Future<void> add(String collection) async {
    await FirebaseFirestore.instance.collection(collection).add({'name': name});
  }
  Future<void> delete() async {
    await FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete();
  }

  Future<void> addAndDelete(String collection, String msg) async {
    Navigator.pop(context);
    await add(collection)
        .then((value) async => await addLog(msg))
        .then((value) => Fluttertoast.showToast(msg: msg))
        .then((value) async => await delete());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
                width: double.infinity,
                // height: 60,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 5.0),
                      ),
                    ],
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.grey[700]),),
                      ),
                      Row(
                        children: [
                          if (userName == value || userName == cordi)
                            AnimatedButton(
                              text: '  Send to\nnext venue', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                              width: 90, color: Colors.green[100], borderRadius: BorderRadius.circular(18),
                              pressEvent: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.topSlide,
                                  desc:  'Tap on venue button to send $name to that venue !',
                                  btnCancel: (list[index] == 'venue1' || list[index] == 'venue4' || list[index] == 'venue6')
                                      ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedButton(
                                          text: 'No', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.red[700]),
                                          width: 70, color: Colors.red[100],
                                          pressEvent: (){Navigator.pop(context);}
                                      ),
                                      const SizedBox(width: 5),
                                      AnimatedButton(
                                          text: list[index + 1], buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                                          width: 90, color: Colors.green[100],
                                          pressEvent: (){addAndDelete(list[index+1], '$name is sent to ${list[index+1].toUpperCase()}');}
                                      ),
                                      const SizedBox(width: 5),
                                      AnimatedButton(
                                          text: list[index + 2], buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                                          width: 90, color: Colors.green[100],
                                          pressEvent: (){addAndDelete(list[index+2], '$name is sent to ${list[index+2].toUpperCase()}');}
                                      ),
                                    ],
                                  )
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedButton(
                                          text: 'No', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.red[700]),
                                          width: 70, color: Colors.red[100],
                                          pressEvent: (){Navigator.pop(context);}
                                      ),
                                      const SizedBox(width: 5),
                                      (list[index] == 'venue2.1' || list[index] == 'venue5.1' || list[index] == 'venue7.1')
                                          ? AnimatedButton(
                                          text: list[index + 2], buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                                          width: 90, color: Colors.green[100],
                                          pressEvent: (){addAndDelete(list[index+2], '$name is sent to ${list[index+2].toUpperCase()}'); }
                                      )
                                          : AnimatedButton(
                                          text: list[index + 1], buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                                          width: 90, color: Colors.green[100],
                                          pressEvent: (){addAndDelete(list[index+1], '$name is sent to ${list[index+1].toUpperCase()}'); }
                                      )
                                    ],
                                  ),
                                ).show();
                              },),
                          const SizedBox(width: 10,),
                          if (userName == cordi)
                            AnimatedButton(
                              text: 'Disqualify', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.red[400]),
                              width: 90, color: Colors.red[100],
                              borderRadius: BorderRadius.circular(18),
                              pressEvent: () {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.topSlide,
                                    desc:  'Are sure to disqualify\n\n$name ?',
                                    btnCancel: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AnimatedButton(
                                            text: 'No', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.red[700]),
                                            width: 70, color: Colors.red[100],
                                            pressEvent: (){Navigator.pop(context);}
                                        ),
                                        const SizedBox(width: 10,),
                                        AnimatedButton(
                                            text: 'Yes', buttonTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: Colors.green[700]),
                                            width: 75, color: Colors.green[100],
                                            pressEvent: () {addAndDelete('disqualify', '$name is disqualified');}
                                        ),
                                      ],
                                    ),
                                ).show();
                              },)
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
