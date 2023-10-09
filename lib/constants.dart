
import 'package:cloud_firestore/cloud_firestore.dart';
late String userUid;
late String userName;
FirebaseFirestore firestore = FirebaseFirestore.instance;
String value = 'teams';
String cordi= 'master';
int index=0;
String cnt = "";

Future<String> getDocumentCount(String collection) async {
  QuerySnapshot snapshot = await firestore.collection(collection).get();
  cnt = snapshot.size.toString();
  print("counting = $cnt");
  return snapshot.size.toString();
}

Future<void> add(String collection, Map<String, dynamic> data) async {
  await firestore.collection(collection).add(data);
}

Future<void> delete(String deleteId) async {
  await firestore.collection(list[index]).doc(deleteId).delete();
}

Future<void> addTeam() async {
  for(String item in teams){
    await add('teams', {'name': item.toUpperCase()})
    // await firestore.collection('teams').add({'name': item.toLowerCase()})
        .then((value) => print("$item added successfully"));
  }
}
List<String> list = ['teams', 'venue1', 'venue2.1', 'venue2.2', 'venue3', 'venue4', 'venue5.1', 'venue5.2', 'venue6', 'venue7.1', 'venue7.2', 'venue8'];
List<String> teams = [
  'Chaapu Log',
  'Khoju',
  'Matrix',
  'Code Breakers 🔥',
  'Ok ok la la la',
  'Skyline',
  'Goal Diggers',
  'Myrukal',
  'nerds and ani bro',
  'OnlyFriends',
  'Kraven',
  'Bhen ka yoda',
  'Team Sigma',
  'Supreme leaders',
  'Duffer hain ji',
  'Dramebaaz',
  'The Trail Blazers',
  'Elite pirates',
  'CDtheLord',
  'Gold diggers',
  'The Famous Five',
  'Team kanyarasi',
  'Shadow Hunters',
  'Inferno Reapers',
  'Gods of Fire',
  'Daku Mangal Singh ki Toli',
  'VEER LOOTERE',
  'Legendary Uphoric Nationalist Dacoits',
  'All-time Studious Students',
  'Association of Smart Students',
  'Rulers of Land',
  'Amber',
  'ORTHO DOCS',
  'Clue Crusaders',
  'Ready to Rumble',
  'Naam Mai Kya Rakha Hai',
  'Lame asses',
  'HAWK EYES',
  'Demon hunters',
  'Vision quest',
  'Furious Finders',
  'Galaxy Gladiators',
  'Bakchod behans',
  'Pathfinder',
  'Matrix 2.0',
  'FANTASTIC FIVE',
      'Amazon Prime',
      'Jagga jasooss',
      'Vertigo',
      'The pirates',
      'The Exiled Predators',
      'Everything you Need',
      'Shikarees',
      'Pirates Of Kanpur',
      'Solo level',
      'Not IITB',
      'The Agents',
      'Normiest Pirates',
      'BombayNaiMila',
      'Best Players',
      'BC (Branch Changers)',
      'Tanmay Sahare',
      'Sherlock ke Bachche',
      'Jalapenos',
      'Jordi Pirates',
      'Hard Hunters',
      'Quickquest five',
      'Khoju',
      'Mighty Hunters',
      'Riemanns',
      'Pirates of the Kelkar-ian',
      'THE WANDERERS',
      'Phoenix Squad',
      'Team 00',
      'Nimbu-choos',
      'Choker69',
      'Gold Diggers',
      'Pirates of Kanpur',
      'Enigma Explorers',
      'Thief Army',
      'Pirates of IITK',
      'Mesmeric Mavericks',
      'Perpetual Motion Squad',
      'Pretty pirates',
      'Quantum Shikari',
      'Mantra Jain',
      'Team Enthu',
      'HUNTER\'S',
      'Pandavas',
      'Brain Drain Crew',
      'Straw Hats',
      'Income Tax Department',
      'Dare Devils',
      '10 Rupaye De Turturre',
      'Treasurers Quad',
      'Mystery Miners',
      'KuchBhi',
      'पांचजन्य',
      'SHERLOCK HOMIES',
      'No name,full fame',
      'Ccd ke 14',
      'Peaky Blinders',
      'Ninja Warriors',
      'Bounty Hunter',
      'SHERLOCK HOMIES',
      'Mystery Miners',
      'Pirates of Nankari',
      'The Treasure Trackers',
      'VSNACC',
      'Vibrant Falcons',
      'Arnav Jain',
      'Famous Five',
      'Sober stoners',
      'MAASC',
      'Veer Jins',
      'Gold Diggers',
      'The treasure trackers',
      'Bakchod Alliance',
      'Loot locaters',
      'YODHAS',
      'Sherlock Holmes',
      'Group of People',
      'Fair and Lovely',
      'Deep Delvers',
      'Haveli Hunters',
      'Clueminati',
      'goldiggers',
      'Quest Explorers',
      'Team Jack Sparrow',
      'The quest crusaders',
      'Paan Kei Saudaagar',
      'The Stellar Squad',
      'Smurf Cats',
      'Xplorer Xperts',
      'Mission 004',
      'DORA THE EXPLORER',
      'Shakaboomers',
      'VSSNACC',
      'Apex Predators',
      'The Treasure Trackers',
      'Übermensch',
      'DOAA-The Explorer',
      'Naughty D3',
      'Ginger Garlic',
      'Clueminati',
      'Saste indiana jones',
      'Leo',
      'JackSparrow',
      'Gold Diggers',
      'Quest Knights',
      'Haveli Hunters',
      'Ravenclaw',
      'Gladiators',
      'Jaamfali Tukdi',
      'Chugli behens',
      'Assaisans',
      'THE CHAINSMOKERS',
      'Amigos',
      'Gold Digger',
      'Exiled Predators',
      'Ayush ptptpt',
      'Saaho pirates',
      'Chomu detectives',
      'Raisen',
      'PEAKY FINDERS',
      'Clever cats',
      'Kela',
      'Treasure Troopers',
      'ʜᴀʀʏᴀɴᴀᴮᵒʸˢ',
      'The furious Finders',
      'Aviators',
      'Jathiratnalu',
      'golddiggers',
      'Family Hunters',
      '8 inches total',
      'Scavenger’s Assemble',
      'Shistammmmm',
      'Hungry cheetahs',
      'Dora the explorer',
      'Maurya',
      'Akele',
      'Dora the explorers',
      'EE SALA CUP NAMDE'];

// void disqualifyDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         alignment: Alignment.center,
//         content: SizedBox(
//           height: 130,
//           child: Column(
//             children: [
//               Text(
//                 'Warning',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w800,
//                     fontSize: 20,
//                     color: Colors.grey[600]),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'Are sure to disqualify ${widget.name.toUpperCase()} ?',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15,
//                     color: Colors.grey[700]),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           Button(
//             fontWeight: FontWeight.w800,
//             buttonText: 'NO',
//             textColor: Colors.grey[700],
//             buttonBgColor: Colors.grey[200],
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             height: 35,
//             width: 80,
//             borderRadius: 15,
//           ),
//           Button(
//             fontWeight: FontWeight.w800,
//             buttonText: 'YES',
//             textColor: Colors.red[500],
//             buttonBgColor: Colors.red[100],
//             onPressed: () async {
//               await FirebaseFirestore.instance.collection('disqualify').add({'name': widget.name});
//               await FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete();
//               Navigator.pop(context);
//             },
//             height: 35,
//             width: 80,
//             borderRadius: 15,
//           ),
//         ],
//       );
//     },
//   );
// }



// void warningDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         alignment: Alignment.center,
//         content: SizedBox(
//           height: 130,
//           child: Column(
//             children: [
//               const Text(
//                 'Warning',
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 'Tap on venue button to send ${widget.name.toUpperCase()} to that venue !',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w800,
//                     fontSize: 15,
//                     color: Colors.grey[500]),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           (list[index] == 'venue1' || list[index] == 'venue4' || list[index] == 'venue6')
//               ? Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Button(
//                 buttonText: 'NO',
//                 textColor: Colors.grey[900],
//                 buttonBgColor: Colors.grey[200],
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 65,
//                 borderRadius: 15,
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Button(
//                 buttonText: list[index + 1],
//                 textColor: Colors.green[800],
//                 buttonBgColor: Colors.green[100],
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection(list[index + 1])
//                       .add({
//                     'name': widget.name,
//                   });
//                   await FirebaseFirestore.instance
//                       .collection(list[index])
//                       .doc(widget.deleteId)
//                       .delete();
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 90,
//                 borderRadius: 15,
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Button(
//                 buttonText: list[index + 2],
//                 textColor: Colors.green[800],
//                 buttonBgColor: Colors.green[100],
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection(list[index + 2])
//                       .add({
//                     'name': widget.name,
//                   });
//                   await FirebaseFirestore.instance
//                       .collection(list[index])
//                       .doc(widget.deleteId)
//                       .delete();
//                   // (isDisqualify)? disqualify() : updateLevel();
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 90,
//                 borderRadius: 15,
//               ),
//             ],
//           )
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Button(
//                 buttonText: 'NO',
//                 textColor: Colors.grey[900],
//                 buttonBgColor: Colors.grey[200],
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 70,
//                 borderRadius: 15,
//               ),
//               const SizedBox(
//                 width: 18,
//               ),
//               (list[index] == 'venue2.1' ||
//                   list[index] == 'venue5.1' ||
//                   list[index] == 'venue7.1')
//                   ? Button(
//                 buttonText: list[index + 2],
//                 textColor: Colors.green[800],
//                 buttonBgColor: Colors.green[100],
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection(list[index + 2])
//                       .add({
//                     'name': widget.name,
//                   });
//                   await FirebaseFirestore.instance
//                       .collection(list[index])
//                       .doc(widget.deleteId)
//                       .delete();
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 70,
//                 borderRadius: 15,
//               )
//                   : Button(
//                 buttonText: list[index + 1],
//                 textColor: Colors.green[800],
//                 buttonBgColor: Colors.green[100],
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection(list[index + 1])
//                       .add({
//                     'name': widget.name,
//                   });
//                   await FirebaseFirestore.instance
//                       .collection(list[index])
//                       .doc(widget.deleteId)
//                       .delete();
//                   Navigator.pop(context);
//                 },
//                 height: 35,
//                 width: 70,
//                 borderRadius: 15,
//               )
//             ],
//           ),
//         ],
//       );
//     },
//   );
// }

// Future<void> updateLevel(String collection) async {
//     await FirebaseFirestore.instance.collection(collection).add({'name': widget.name,}).then((value) => null);
//   await FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete()
//       .then((value) async => await addLog('${widget.name.toUpperCase()} is sent to ${collection.toUpperCase()}'))
//       .then((value) => Fluttertoast.showToast(msg: 'Successfully sent ${widget.name.toUpperCase()}'));
// }

// Future<void> disQualify() async {
//   await FirebaseFirestore.instance.collection('disqualify').add({'name': widget.name});
//   await FirebaseFirestore.instance.collection(list[index]).doc(widget.deleteId).delete()
//       .then((value) async => await addLog('${widget.name.toUpperCase()} is disqualified'))
//       .then((value) => Fluttertoast.showToast(msg: '${widget.name.toUpperCase()} is Disqualified'));
// }


// Future<void> updateLevel(String collection) async {
//   await add(collection)
//       .then((value) async => await addLog('${widget.name.toUpperCase()} is sent to ${collection.toUpperCase()}'))
//       .then((value) => Fluttertoast.showToast(msg: 'Successfully sent ${widget.name.toUpperCase()}'))
//       .then((value) async => await delete());
// }

// Future<void> disQualify() async {
//   await add('disqualify')
//       .then((value) async => await addLog('${widget.name.toUpperCase()} is disqualified'))
//       .then((value) => Fluttertoast.showToast(msg: '${widget.name.toUpperCase()} is Disqualified'))
//       .then((value) async => await delete());
// }