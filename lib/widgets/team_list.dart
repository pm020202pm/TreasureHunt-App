import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treasure/widgets/user_card.dart';

import '../constants.dart';
import '../provider/count.dart';
class TeamList extends StatelessWidget {
  final String name;
  const TeamList({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Value>(
      builder:(context, value, child)=> Padding(
        padding: EdgeInsets.fromLTRB(0, (userName==cordi)? 180:140, 0, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection(value.val).orderBy('name').limit(6).startAt([name]).endAt(["$name\uf8ff"]).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) { return const Center(child: CircularProgressIndicator()); }
            if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var nam = data['name'];
                var id = data.id;
                return UserCard(name: nam, deleteId: id);
              },
            );
          },
        ),
      ),
    );
  }
}
