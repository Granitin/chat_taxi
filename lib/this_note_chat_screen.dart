import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThisNoteChatScreen extends StatelessWidget {
  const ThisNoteChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ThisNoteChatScreenBody();
  }
}

class ThisNoteChatScreenBody extends StatefulWidget {
  const ThisNoteChatScreenBody({Key? key}) : super(key: key);

  @override
  State<ThisNoteChatScreenBody> createState() => _ThisNoteChatScreenBodyState();
}

class _ThisNoteChatScreenBodyState extends State<ThisNoteChatScreenBody> {
  @override
  Widget build(BuildContext context) {
    return const ChatAboutThisNote();
  }
}

class ChatAboutThisNote extends StatefulWidget {
  const ChatAboutThisNote({Key? key}) : super(key: key);

  @override
  State<ChatAboutThisNote> createState() => _ChatAboutThisNoteState();
}

class _ChatAboutThisNoteState extends State<ChatAboutThisNote> {
  final Stream<QuerySnapshot> _thisNoteChatStream =
      FirebaseFirestore.instance.collection("notes").snapshots();

  @override
  void initState() {
    _thisNoteChatStream;
    super.initState();
  }

  final _thisDriverChatUid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Чат'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _thisNoteChatStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    color: const Color.fromARGB(255, 120, 184, 236),
                    child: const Text('Говорим об этой заявке:'),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Expanded(
                    child: ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        var valuesList = data.values.toList();

                        var uidNote = data.entries
                            .firstWhere((entry) => entry.key == 'uidNote')
                            .value;

                        var driverChat = data.entries
                            .firstWhere(
                                (entry) => entry.key == 'uidDriverToChat')
                            .value;

                        var uidPassangerToChat = data.entries
                            .firstWhere((entry) => entry.key == 'uidPassanger')
                            .value;

                        var adressFromToChat = data.entries
                            .firstWhere((entry) => entry.key == 'adressFrom')
                            .value;
                        var adressToGoToChat = data.entries
                            .firstWhere((entry) => entry.key == 'adressToGo')
                            .value;

                        var passangerPriceChat = data.entries
                            .firstWhere(
                                (entry) => entry.key == 'passangerPrice')
                            .value;

                        var index = 0;

                        for (var item in valuesList) {
                          if (uidPassangerToChat! == _thisDriverChatUid) {
                            return Container();
                          }
                        }

                        return Dismissible(
                          key: Key(snapshot.data!.docs[index].id),
                          child: Card(
                            color: Colors.amber[100],
                            key: Key(snapshot.data!.docs[index].id),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Заявка - $uidNote"),
                                  Text("Пассажир - $uidPassangerToChat"),
                                  Text('Водитель - $driverChat'),
                                  Text("Адрес подачи - $adressFromToChat"),
                                  Text("Конечный адрес - $adressToGoToChat"),
                                  Text('Цена пассажира - $passangerPriceChat'),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      // !!!!!!!!!!!!
                    ),
                  ),
                  Container(
                    height: 20,
                    color: Colors.green[600],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
