import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treasure/widgets/text_button.dart';
import '../constants.dart';
import '../provider/count.dart';
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

  List<DocumentSnapshot> documents = [];

  ///////////////////////////////////////////////////////////////////////
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection(value);
  final int itemsPerPage = 10;
  DocumentSnapshot? lastDocument;
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  Stream<QuerySnapshot<Map<String, dynamic>>> paginatedData() async* {
    while (true) {
      Query query = collectionReference.orderBy('name').limit(itemsPerPage);
      if (lastDocument != null) {query = query.startAfterDocument(lastDocument!);}
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get() as QuerySnapshot<Map<String, dynamic>>;
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
      if (documents.isEmpty) {break;}
      lastDocument = documents.last;
      yield querySnapshot;
    }
  }

  void _loadNextPage() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final documents = await paginatedData().first;
      setState(() {
        isLoading = false;
      });
    }
  }
  //////////////////////////////////////////////////////////

  // Future<QuerySnapshot> fetchData() async {
  //   QuerySnapshot querySnapshot;
  //   if (lastDocument == null) {
  //     querySnapshot = await collectionReference.orderBy('name').limit(itemsPerPage).get();
  //   } else {
  //     querySnapshot = await collectionReference.orderBy('name').startAfterDocument(lastDocument!).limit(itemsPerPage).get();
  //   }
  //   documents.add(querySnapshot);
  //   return querySnapshot;
  // }


  Future<void> number() async {
    String num = await getDocumentCount(value);
    setState(() {
      count =num ;
    });
  }

  @override
  void initState() {
    number();
    super.initState();
    _scrollController.addListener(_loadNextPage);
    stream = paginatedData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
    _scrollController.addListener(_loadNextPage);
    stream = paginatedData();
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
              MyDropdown(name: name),
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
                  Button(buttonText: "Add", textColor: Colors.green[700], buttonBgColor: Colors.green[100], onPressed: (){add('teams', {'name': team.text.toUpperCase()}).then((value) => team.clear());}, height: 50, width: 70, borderRadius: 18)
                ],
              ),
              // Button(buttonText: 'Text', textColor: Colors.purple, buttonBgColor: Colors.grey, onPressed: (){addTeam();}, height: 30, width: 70, borderRadius: 15),
            ],
          ),
        ),
    Consumer<Value>(
      builder:(context, val, child) =>Padding(
        padding: EdgeInsets.fromLTRB(0, (userName==cordi)? 180:140, 0, 0),
        child: StreamBuilder<QuerySnapshot>(
          stream:stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) { return const Center(child: CircularProgressIndicator()); }
            if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
            lastDocument = snapshot.data!.docs.last;
            return ListView.builder(
              controller: _scrollController,
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index];
                // var data = snapshot.data!.docs[index];
                var nam = data['name'];
                var id = data.id;
                return UserCard(name: nam, deleteId: id);
              },
            );
          },
        ),
      ),
    )
      ],
    );
  }
}