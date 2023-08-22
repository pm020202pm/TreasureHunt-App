import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';

class DisqualifyTab extends StatefulWidget {
  const DisqualifyTab({Key? key}) : super(key: key);
  @override
  State<DisqualifyTab> createState() => _DisqualifyTabState();
}

class _DisqualifyTabState extends State<DisqualifyTab> {

  Future<List<QueryDocumentSnapshot>> fetchRequestsDocuments() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('disqualify').get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 70, 8, 8),
      child: FutureBuilder<List<QueryDocumentSnapshot>>(
        future: fetchRequestsDocuments(),
        builder: (BuildContext context,
            AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { return const Center(child: CircularProgressIndicator()); }
          if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
          List<QueryDocumentSnapshot> documents = snapshot.data!;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              var name = documents[index].get('name');
              var id = documents[index].id;
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          width: screenSize.width*0.9,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(name.toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700]),),
                                Button(buttonText: 'Disqualified', textColor: Colors.grey[800], buttonBgColor: Colors.grey[350], onPressed: () { }, height: 40, width: 100, borderRadius: 15,),
                              ],
                            ),
                          )
                      )
                    ],
                  )
              );
            },
          );
        },
      ),
    );
  }
}
