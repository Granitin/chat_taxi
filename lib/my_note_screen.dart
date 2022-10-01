// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/make_new_note_screen.dart';
import 'package:chat_taxi/my_note_redaction_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// arguments: [
//                   uidNote, 0
//                   uidPassanger, 1
//                   uidDriverToChat, 2
//                   adressFrom, 3
//                   adressToGo, 4
//                   childrenCount, 5
//                   whatAnimal, 6
//                   remark, 7
//                   passangerPrice, 8
//                 ],

class MyNoteWidget extends StatelessWidget {
  const MyNoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final infoMyNote = ModalRoute.of(context)?.settings.arguments as List;

    final uidNote = infoMyNote.elementAt(0);
    final uidPassanger = infoMyNote.elementAt(1);
    final uidDriverToChat = infoMyNote.elementAt(2);
    final adressFrom = infoMyNote.elementAt(3);
    final adressToGo = infoMyNote.elementAt(4);
    final childrenCount = infoMyNote.elementAt(5);
    final whatAnimal = infoMyNote.elementAt(6);
    final remark = infoMyNote.elementAt(7);
    final passangerPrice = infoMyNote.elementAt(8);

    final TextEditingController chatMessageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text("Моя заявка"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.yellow.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'uidNote - $uidNote',
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                    // Text(
                    //   'uidPassanger - $uidPassanger',
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //   ),
                    // ),
                    // Text(
                    //   'uidDriver - $uidDriverToChat',
                    //   style: const TextStyle(
                    //     fontSize: 12,
                    //   ),
                    // ),
                    Text(
                      'Адрес подачи - $adressFrom',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Конечный адрес - $adressToGo',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Дети до 7 лет - $childrenCount',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Звери - $whatAnimal',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Примечание - $remark',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Моя цена - $passangerPrice  руб.',
                      style: const TextStyle(
                        backgroundColor: Color.fromARGB(255, 241, 176, 176),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
//------------------------

                SizedBox(
                  height: 25,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () async {
                      final idNote = FirebaseAuth.instance.currentUser?.uid;

                      final docRef = FirebaseFirestore.instance
                          .collection("notes")
                          .doc(idNote);

                      docRef.get().then(
                        (DocumentSnapshot doc) async {
                          if (!doc.exists) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('У вас нет заявки'),
                                    content: TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const NoteFormWidget(),
                                            ),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: const Text('Создать заявку')),
                                  );
                                });
                          }

                          final data = doc.data() as Map<String, dynamic>;

                          var uidPassanger = data.entries
                              .firstWhere(
                                  (entry) => entry.key == 'uidPassanger')
                              .value;

                          var uidNote = data.entries
                              .firstWhere((entry) => entry.key == 'uidNote')
                              .value;

                          var uidDriverToChat = data.entries
                              .firstWhere(
                                  (entry) => entry.key == 'uidDriverToChat')
                              .value;

                          var adressFrom = data.entries
                              .firstWhere((entry) => entry.key == 'adressFrom')
                              .value;

                          var adressToGo = data.entries
                              .firstWhere((entry) => entry.key == 'adressToGo')
                              .value;

                          var isChildren = data.entries
                              .firstWhere((entry) => entry.key == 'isChildren')
                              .value;

                          var childrenCount = data.entries
                              .firstWhere(
                                  (entry) => entry.key == 'childrenCount')
                              .value;

                          var isAnimals = data.entries
                              .firstWhere((entry) => entry.key == 'isAnimals')
                              .value;

                          var whatAnimal = data.entries
                              .firstWhere((entry) => entry.key == 'whatAnimal')
                              .value;

                          var remark = data.entries
                              .firstWhere((entry) => entry.key == 'remark')
                              .value;

                          var passangerPrice = data.entries
                              .firstWhere(
                                  (entry) => entry.key == 'passangerPrice')
                              .value;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NoteRedactionFormWidget(),
                              settings: RouteSettings(
                                arguments: [
                                  uidNote,
                                  uidPassanger,
                                  uidDriverToChat,
                                  adressFrom,
                                  adressToGo,
                                  childrenCount,
                                  whatAnimal,
                                  remark,
                                  passangerPrice,
                                ],
                              ),
                            ),
                          );
                        },
                        onError: (e) => print("Error getting document: $e"),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Редактировать',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 25,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      deleteMyNote();

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.yellow,
                              title: const Text(
                                'Заявка удалена',
                                textAlign: TextAlign.center,
                              ),
                              content: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NoteFormWidget(),
                                        ),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: const Text('Создать заявку'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: const Text('Главный экран'),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Text(
                      'Удалить',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Главный экран',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            //----------------------------------------          chat         -----------------------
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notes')
                  .doc(uidNote)
                  .collection('chat_messages')
                  .orderBy('timeOfMessage')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: Expanded(
                          child: ListView(
                            children: snapshot.data!.docs.map(
                              (DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;

                                var chatMessage = data.entries
                                    .firstWhere(
                                        (entry) => entry.key == 'new message')
                                    .value;
                                var whatCarDriver = data.entries
                                    .firstWhere(
                                        (entry) => entry.key == 'whatCarDriver')
                                    .value;

                                var colorCarDriver = data.entries
                                    .firstWhere((entry) =>
                                        entry.key == 'colorCarDriver')
                                    .value;

                                var numberCarDriver = data.entries
                                    .firstWhere((entry) =>
                                        entry.key == 'numberCarDriver')
                                    .value;

                                var index = 0;
                                return Row(
                                  children: [
                                    Text('- $chatMessage  '),
                                    Container(
                                      color: const Color.fromARGB(
                                          255, 108, 163, 207),
                                      child: (whatCarDriver == null ||
                                              colorCarDriver == null ||
                                              numberCarDriver == null)
                                          ? const SizedBox.shrink()
                                          : Text(
                                              ' - $whatCarDriver, $colorCarDriver, $numberCarDriver'),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                            // !!!!!!!!!!!!
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

//----------------------------------------      end of    chat         -----------------------
            SizedBox(
              height: 50,
              child: Expanded(
                child: TextFormField(
                  autofocus: true,
                  controller: chatMessageController,
                  decoration: InputDecoration(
                    labelText: "Пассажир, ваше предложение",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        var newChatMessage = chatMessageController.text;
                        final timeOfMessage = DateTime.now();
                        await FirebaseFirestore.instance
                            .collection('notes')
                            .doc(uidNote)
                            .collection('chat_messages')
                            .add({
                          'new message': newChatMessage,
                          'timeOfMessage': timeOfMessage,
                          'whatCarDriver': null,
                          'colorCarDriver': null,
                          'numberCarDriver': null,
                        });

                        chatMessageController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),

//-------------------   ---------------------
          ],
        ),
      ),
    );
  }
}

Future<void> deleteMyNote() async {
  final idNoteToDelete = FirebaseAuth.instance.currentUser?.uid;

  await FirebaseFirestore.instance
      .collection("notes")
      .doc(idNoteToDelete)
      .collection("chat_messages")
      .get()
      .then((value) {
    for (var data in value.docs) {
      FirebaseFirestore.instance
          .collection("notes")
          .doc(idNoteToDelete)
          .collection("chat_messages")
          .doc(data.id)
          .delete()
          .then((value) {
        FirebaseFirestore.instance
            .collection("notes")
            .doc(idNoteToDelete)
            .delete();
      });
    }
  });
}
