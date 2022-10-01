// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Future<void> getInfoThisNote() async {
//   final idNote = FirebaseAuth.instance.currentUser?.uid;
//   final docRef = FirebaseFirestore.instance.collection("notes").doc(idNote);
//   int uidPassanger;
//   docRef.get().then(
//     (DocumentSnapshot doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       var uidPassanger =
//           data.entries.firstWhere((entry) => entry.key == 'uidPassanger').value;
//       return uidPassanger;
//       print(data);
//     },
//     onError: (e) => print("Error getting document: $e"),
//   );
// }

class ThisNoteScreenWidget extends StatefulWidget {
  const ThisNoteScreenWidget({Key? key}) : super(key: key);

  @override
  State<ThisNoteScreenWidget> createState() => _ThisNoteScreenWidgetState();
}

class _ThisNoteScreenWidgetState extends State<ThisNoteScreenWidget> {
  @override
  Widget build(BuildContext context) {
    void getInfoThisNote() async {
      final idNote = FirebaseAuth.instance.currentUser?.uid;
      final docRef = FirebaseFirestore.instance.collection("notes").doc(idNote);
      int uidPassanger;
      docRef.get().then((DocumentSnapshot doc) {});
    }

    String uidPassanger;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя заявка'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Text('uidPassanger'),
                Text('adressFrom'),
                Text('adressToGo'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------
//---------------------------------
//-------------------------------

// class ThisNotesScreenWidget extends StatefulWidget {
//   const ThisNotesScreenWidget({Key? key}) : super(key: key);

//   @override
//   State<ThisNotesScreenWidget> createState() => _ThisNoteScreenWidgetState();
// }

// class _ThisNotesScreenWidgetState extends State<ThisNoteScreenWidget> {
//   final Stream<QuerySnapshot> _thisNoteStream =
//       FirebaseFirestore.instance.collection("notes").snapshots();

//   final _thisUserUid = FirebaseAuth.instance.currentUser?.uid;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Моя заявка'),
//       ),
//       body: SafeArea(
//         child: StreamBuilder<QuerySnapshot>(
//             stream: _thisNoteStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (!snapshot.hasData) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               return Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),

//                     Expanded(
//                       flex: 1,
//                       child: ListView(
//                         children: snapshot.data!.docs
//                             .map((DocumentSnapshot document) {
//                           Map<String, dynamic> data =
//                               document.data()! as Map<String, dynamic>;

//                           var uidPassanger = data.entries
//                               .firstWhere(
//                                   (entry) => entry.key == 'uidPassanger')
//                               .value;

//                           var uidNote = data.entries
//                               .firstWhere((entry) => entry.key == 'uidNote')
//                               .value;

//                           var uidDriverToChat = data.entries
//                               .firstWhere(
//                                   (entry) => entry.key == 'uidDriverToChat')
//                               .value;

//                           var adressFrom = data.entries
//                               .firstWhere((entry) => entry.key == 'adressFrom')
//                               .value;

//                           var adressToGo = data.entries
//                               .firstWhere((entry) => entry.key == 'adressToGo')
//                               .value;

//                           var isChildren = data.entries
//                               .firstWhere((entry) => entry.key == 'isChildren')
//                               .value;

//                           var childrenCount = data.entries
//                               .firstWhere(
//                                   (entry) => entry.key == 'childrenCount')
//                               .value;

//                           var isAnimals = data.entries
//                               .firstWhere((entry) => entry.key == 'isAnimals')
//                               .value;

//                           var whatAnimal = data.entries
//                               .firstWhere((entry) => entry.key == 'whatAnimal')
//                               .value;

//                           var remark = data.entries
//                               .firstWhere((entry) => entry.key == 'remark')
//                               .value;

//                           var passangerPrice = data.entries
//                               .firstWhere(
//                                   (entry) => entry.key == 'passangerPrice')
//                               .value;

//                           if (uidPassanger != _thisUserUid) {
//                             return const SizedBox.shrink();
//                           }

//                           return Card(
//                             color: Colors.grey[400],
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 3),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('uid Пассажира - $uidPassanger'),
//                                   Text('uid Заявки - $uidNote'),
//                                   Text('uid Водителя - $uidDriverToChat'),
//                                   Text('Адрес подачи - $adressFrom'),
//                                   Text('Конечный адрес - $adressToGo'),
//                                   Text(
//                                       'Количество детей до 7 лет - $childrenCount'),
//                                   Text('Животное с собой - $whatAnimal'),
//                                   Text('Доп.информация - $remark'),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         color: const Color.fromARGB(
//                                             255, 163, 221, 192),
//                                         height: 17,
//                                         child: Text(
//                                             'Моя цена - $passangerPrice руб.'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _noteDelete();
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (BuildContext context) =>
//                                                   const NoteFormWidget(),
//                                             ),
//                                           );
//                                         },
//                                         child: const Text('Редактировать'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           _noteDelete();
//                                         },
//                                         child: const Text(
//                                           'Удалить',
//                                           style: TextStyle(
//                                             color: Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         // !!!!!!!!!!!!
//                       ),
//                     ),
//                     // const DriverInfoVidget(),
//                     // const ChatWidget(),
//                     // const MessageWidget(),
//                   ],
//                 ),
//               );
//             }),
//       ),
//     );
//   }
// }

// Future<void> _noteDelete() async {
//   final idNoteToDelete = FirebaseAuth.instance.currentUser?.uid;

//   await FirebaseFirestore.instance
//       .collection("notes")
//       .doc(idNoteToDelete)
//       .delete();

//   print('заявка удалена');
// }

// class ChatWidget extends StatefulWidget {
//   const ChatWidget({Key? key}) : super(key: key);

//   @override
//   State<ChatWidget> createState() => _ChatWidgetState();
// }

// var _idPassanger = FirebaseAuth.instance.currentUser?.uid;

// class _ChatWidgetState extends State<ChatWidget> {
//   final Stream<QuerySnapshot> _chatPassangerSnapshots = FirebaseFirestore
//       .instance
//       .collection("notes")
//       .doc(_idPassanger)
//       .collection('messages')
//       .snapshots();

//   @override
//   void initState() {
//     _chatPassangerSnapshots;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _chatPassangerSnapshots,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return Expanded(
//             // flex: 1,
//             child: ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;

//                 var textChat = data.entries
//                     .firstWhere((entry) => entry.key == 'textOfPrivatChat')
//                     .value;

//                 // print(_textChat);

//                 var index = 0;

//                 return SingleChildScrollView(
//                   child: Dismissible(
//                     key: Key(snapshot.data!.docs[index].id),
//                     child: Card(
//                       color: const Color.fromARGB(255, 177, 240, 94),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 3),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Текст:',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 15,
//                                   color: Color.fromRGBO(26, 197, 41, 1)),
//                             ),
//                             Text(textChat),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//               // !!!!!!!!!!!!
//             ),
//           );
//         });
//   }
// }
