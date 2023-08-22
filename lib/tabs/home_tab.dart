import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treasure/widgets/button.dart';
import 'package:treasure/widgets/custom_textfield.dart';
import '../constants.dart';
import '../widgets/my_dropdown.dart';
import '../widgets/user_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController teamName = TextEditingController();
  var name = '';

  Future<void> addTeam() async {
    if(teamName.text!='') {
      await FirebaseFirestore.instance.collection('teams').add({
        'name': teamName.text.toLowerCase(),
      }).then((value) => print("team added successfully")).catchError((error) =>
          print("Failed to add team: $error"));
      teamName.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          MyDropdown(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 60,),
                Container(
                    // width: screenSize.width*0.85,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1,),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue, width: 1,),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      onChanged: (val){
                        setState(() {
                          name=val.toLowerCase();
                        });
                      },
                    ),
                ),
                const SizedBox(height: 16,),
                if(userName==cordi)Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          controller: teamName,
                          hintText: 'Team name',
                          obscureText: false,
                          boxHeight: 50),
                    ),
                    const SizedBox(width: 10,),
                    Button(
                        buttonText: "Add",
                        textColor: Colors.green[600], buttonBgColor: Colors.green[100],
                        onPressed: (){ addTeam();},
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        height: 50, width: 80, borderRadius: 20)
                  ],
                )
              ],
            ),
          ),
      Padding(
        padding: EdgeInsets.fromLTRB(0, (userName==cordi)? 200: 130, 0, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(value)
              .orderBy('name')
              .startAt([name])
              .endAt([name + "\uf8ff"])
              .snapshots(),
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
      )
        ],
      ),
    );
  }
}