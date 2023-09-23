import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DisqualifyTab extends StatefulWidget {
  const DisqualifyTab({Key? key}) : super(key: key);
  @override
  State<DisqualifyTab> createState() => _DisqualifyTabState();
}

class _DisqualifyTabState extends State<DisqualifyTab> {
  String count="";
  Future<void> number() async {
    String num = await getDocumentCount('disqualify');
    setState(() {
      count =': $num' ;
    });
  }

  @override
  void initState() {
    number();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 12, 30),
            child: Text("Disqualified Teams $count", style: TextStyle(fontWeight: FontWeight.w900, fontSize:32, color: Colors.grey[500]),),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('disqualify').orderBy('name').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) { return const Center(child: CircularProgressIndicator()); }
                if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    var name = data['name'];
                    return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                            width: screenSize.width*0.9,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.grey.shade300),
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(name.toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700]),),
                            )
                        )
                      ],
                    )
                );
              },
            );
        },
      ),
          ),
    ]);
  }
}
