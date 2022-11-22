import 'dart:async';

import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/note_delete_for_driver_screen.dart';
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
        backgroundColor: AppColors.darkColor,
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
            _NoteAboutChatWidget(
                adressFrom: adressFrom,
                adressToGo: adressToGo,
                childrenCount: childrenCount,
                whatAnimal: whatAnimal,
                remark: remark,
                passangerPrice: passangerPrice),
            _ChatDriverWidget(uidNote: uidNote),
            _DriverInputMessageWidget(
                chatMessageController: chatMessageController, uidNote: uidNote),
          ],
        ),
      ),
    );
  }
}

class _DriverInputMessageWidget extends StatelessWidget {
  const _DriverInputMessageWidget({
    Key? key,
    required this.chatMessageController,
    required this.uidNote,
  }) : super(key: key);

  final TextEditingController chatMessageController;
  final uidNote;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
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
                (prefs.getString('numberCarDriver') ?? 'нет данных');

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
    );
  }
}

class _ChatDriverWidget extends StatefulWidget {
  const _ChatDriverWidget({
    Key? key,
    required this.uidNote,
  }) : super(key: key);

  final uidNote;

  @override
  State<_ChatDriverWidget> createState() => _ChatDriverWidgetState();
}

class _ChatDriverWidgetState extends State<_ChatDriverWidget> {
  @override
  Widget build(BuildContext context) {
    final chatMessagesStream = FirebaseFirestore.instance
        .collection('notes')
        .doc(widget.uidNote)
        .collection('chat_messages')
        .snapshots();

    final chatMessages = chatMessagesStream.contains('ЗАЯВКА УДАЛЕНА');
    print(chatMessagesStream.toString());
    print(chatMessages);

    final StreamController streamChatController = StreamController();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notes')
          .doc(widget.uidNote)
          .collection('chat_messages')
          .orderBy('timeOfMessage', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final ScrollController chatScrollController = ScrollController();

        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: ListView(
                  reverse: true,
                  controller: chatScrollController,
                  children: snapshot.data!.docs.map(
                    (DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      var chatMessage = data.entries
                          .firstWhere((entry) => entry.key == 'new message')
                          .value;
                      var whatCarDriver = data.entries
                          .firstWhere((entry) => entry.key == 'whatCarDriver')
                          .value;

                      var colorCarDriver = data.entries
                          .firstWhere((entry) => entry.key == 'colorCarDriver')
                          .value;

                      var numberCarDriver = data.entries
                          .firstWhere((entry) => entry.key == 'numberCarDriver')
                          .value;

                      var timeOfMessage = data.entries
                          .firstWhere((entry) => entry.key == 'timeOfMessage')
                          .value;

                      var index = 0;

                      if (!chatMessage.toString().contains('ЗАЯВКА УДАЛЕНА')) {
                        return Column(
                          children: [
                            _ChatRowDriver(
                                chatMessage: chatMessage,
                                whatCarDriver: whatCarDriver,
                                colorCarDriver: colorCarDriver,
                                numberCarDriver: numberCarDriver),
                            const Divider(
                              color: Colors.black,
                            ),
                          ],
                        );
                      } else {
                        return const AlertDialog(
                          title: Text('заявка удалена'),
                        );

                        // return Navigator(
                        //   onGenerateRoute: ((settings) {
                        //     return MaterialPageRoute(
                        //       builder: (context) => const FreeNotesScreen(),
                        //     );
                        //   }),
                        //   // initialRoute: '/',
                        // );
                      }
                    },
                  ).toList(),
                  // !!!!!!!!!!!!
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChatRowDriver extends StatelessWidget {
  _ChatRowDriver({
    Key? key,
    required this.chatMessage,
    required this.whatCarDriver,
    required this.colorCarDriver,
    required this.numberCarDriver,
  }) : super(key: key);

  var chatMessage;
  var whatCarDriver;
  var colorCarDriver;
  var numberCarDriver;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '- $chatMessage  ',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Expanded(
          flex: 2,
          child: (whatCarDriver == null ||
                  colorCarDriver == null ||
                  numberCarDriver == null)
              ? const Icon(Icons.man)
              : Text(
                  '$whatCarDriver, $colorCarDriver, $numberCarDriver',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      backgroundColor: Colors.yellow.shade300),
                ),
        ),
      ],
    );
  }
}

class _NoteAboutChatWidget extends StatelessWidget {
  const _NoteAboutChatWidget({
    Key? key,
    required this.adressFrom,
    required this.adressToGo,
    required this.childrenCount,
    required this.whatAnimal,
    required this.remark,
    required this.passangerPrice,
  }) : super(key: key);

  final adressFrom;
  final adressToGo;
  final childrenCount;
  final whatAnimal;
  final remark;
  final passangerPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
