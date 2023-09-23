import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:treasure/widgets/text_button.dart';
import '../constants.dart';
import '../widgets/my_dropdown.dart';
import '../widgets/user_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController team = TextEditingController();
  var name = '';
  String count = "";

  // Future<void> addTeam() async {
  //   for(String item in teams){
  //     await FirebaseFirestore.instance.collection('teams').add({
  //       'name': item.toLowerCase(),
  //     }).then((value) => print("$item added successfully"));
  //   }
  // }


  Future<void> addNew() async {
    await FirebaseFirestore.instance.collection('teams').add({'name': team.text});
    team.clear();
  }


  Future<void> number() async {
    String num = await getDocumentCount(value);
    setState(() {
      count ='$num' ;
    });
  }

  @override
  void initState() {
    number();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyDropdown(),
              Button(buttonText: 'Total Teams = $count', textColor: Colors.blue, buttonBgColor: Colors.blue[100], onPressed: (){}, height: 35, width: 180, borderRadius: 10)
            ],
          ),
        ),
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
              const SizedBox(height: 10,),
              if(userName==cordi) Row(
                children: [
                  Expanded(
                    child: Container(
                      // width: screenSize.width*0.85,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: team,
                        decoration: const InputDecoration(
                          hintText: 'Add new team',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue, width: 1,),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Button(buttonText: "Add", textColor: Colors.green[700], buttonBgColor: Colors.green[100], onPressed: (){addNew();}, height: 50, width: 70, borderRadius: 18)
                ],
              ),
              // Button(buttonText: 'Text', textColor: Colors.purple, buttonBgColor: Colors.grey, onPressed: (){addTeam();}, height: 30, width: 70, borderRadius: 15),

            ],
          ),
        ),
    Padding(
      padding: EdgeInsets.fromLTRB(0, (userName==cordi)? 180:140, 0, 0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(value)
            .orderBy('name')
            .startAt([name])
            .endAt(["$name\uf8ff"])
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
    );
  }
}