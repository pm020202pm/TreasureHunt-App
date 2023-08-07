import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treasure/widgets/user_card.dart';
import 'constants.dart';

class TeamList extends StatefulWidget {
  const TeamList({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {

  Future<List<QueryDocumentSnapshot>> fetchRequestsDocuments() async {
    final querySnapshot = await FirebaseFirestore.instance.collection(value).get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 90, 8, 8),
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
              var nam = documents[index].get('name');
              var id = documents[index].id;
              if(widget.name.isEmpty){
                return UserCard(name: nam, deleteId: id, );
              }
              if(nam.toString().toLowerCase().startsWith(widget.name.toLowerCase())){
                return UserCard(name: nam, deleteId: id, );
              }
            },
          );
        },
      ),
    );
  }
}
