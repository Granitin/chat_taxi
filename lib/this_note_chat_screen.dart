import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// arguments: [
//                                                         uidNote, 0
//                                                         uidPassanger, 1
//                                                         uidDriverToChat, 2
//                                                         adressFrom, 3
//                                                         adressToGo, 4
//                                                         childrenCount, 5
//                                                         whatAnimal, 6
//                                                         remark, 7 price -8

//                                                       ],

Future<void> _loadDriverData() async {
  final prefs = await SharedPreferences.getInstance();
  final whatCarDriver = (prefs.getString('whatCarDriver') ?? 'нет данных');
  final colorCarDriver = (prefs.getString('colorCarDriver') ?? 'нет данных');
  final numberCarDriver = (prefs.getString('numberCarDriver') ?? 'нет данных');
}

class NoteToChat extends StatelessWidget {
  const NoteToChat({super.key});

  @override
  Widget build(BuildContext context) {
    final infoNoteToChat = ModalRoute.of(context)!.settings.arguments as List;

    final uidNote = infoNoteToChat.elementAt(0);
    final uidPassanger = infoNoteToChat.elementAt(1);
    final uidDriverToChat = infoNoteToChat.elementAt(2);
    final adressFrom = infoNoteToChat.elementAt(3);
    final adressToGo = infoNoteToChat.elementAt(4);
    final childrenCount = infoNoteToChat.elementAt(5);
    final whatAnimal = infoNoteToChat.elementAt(6);
    final remark = infoNoteToChat.elementAt(7);
    final passangerPrice = infoNoteToChat.elementAt(8);

    final TextEditingController chatMessageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Text("Чат по заявке:"),
            const SizedBox(
              width: 10,
            ),
            Text(
              "$passangerPrice",
              style: const TextStyle(color: Colors.yellow),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text('руб.'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              color: Colors.yellow.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('uidNote - $uidNote'),
                      // Text('uidPassanger - $uidPassanger'),
                      // Text('uidDriver - $uidDriverToChat'),
                      Text('Адрес подачи - $adressFrom'),
                      Text('Конечный адрес - $adressToGo'),
                      Text('Дети до 7 лет - $childrenCount'),
                      Text('Звери - $whatAnimal'),
                      Text('Примечание - $remark'),
                      Text(
                        'Цена пассажира - $passangerPrice руб.',
                        style: const TextStyle(
                          backgroundColor: Color.fromARGB(255, 241, 176, 176),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                final ScrollController _scrollController = ScrollController();

                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 190,
                        child: ListView(
                          controller: _scrollController,
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
                                  .firstWhere(
                                      (entry) => entry.key == 'colorCarDriver')
                                  .value;

                              var numberCarDriver = data.entries
                                  .firstWhere(
                                      (entry) => entry.key == 'numberCarDriver')
                                  .value;

                              var index = 0;
                              return Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '- $chatMessage',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  Container(
                                    color: const Color.fromARGB(
                                        255, 153, 194, 228),
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
                    labelText: "Водитель, ваше предложение",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        var newChatMessage = chatMessageController.text;
                        final timeOfMessage = DateTime.now();

                        final prefs = await SharedPreferences.getInstance();
                        final whatCarDriver =
                            (prefs.getString('whatCarDriver') ?? 'нет данных');
                        final colorCarDriver =
                            (prefs.getString('colorCarDriver') ?? 'нет данных');
                        final numberCarDriver =
                            (prefs.getString('numberCarDriver') ??
                                'нет данных');

                        await FirebaseFirestore.instance
                            .collection('notes')
                            .doc(uidNote)
                            .collection('chat_messages')
                            .add({
                          'new message': newChatMessage,
                          'whatCarDriver': whatCarDriver,
                          'colorCarDriver': colorCarDriver,
                          'numberCarDriver': numberCarDriver,
                          'timeOfMessage': timeOfMessage,
                        });

                        chatMessageController.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
