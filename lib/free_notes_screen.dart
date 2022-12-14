import 'package:chat_taxi/domain/note.dart';
import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/this_note_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FreeNotesController extends ChangeNotifier {
  final Stream<QuerySnapshot> notesSrteam = FirebaseFirestore.instance
      .collection("notes")
      .orderBy('passangerPrice')
      .snapshots();
}

class FreeNotesScreen extends StatelessWidget {
  const FreeNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => FreeNotesController(),
        child: const FreeNotesScreenBody(),
      );
}

class FreeNotesScreenBody extends StatefulWidget {
  const FreeNotesScreenBody({Key? key}) : super(key: key);

  @override
  State<FreeNotesScreenBody> createState() => _FreeNotesScreenBodyState();
}

class _FreeNotesScreenBodyState extends State<FreeNotesScreenBody> {
  String myCity = '';

  @override
  void initState() {
    super.initState();
    _loadMyCity();
    setState(() {});
  }

  Future<void> _loadMyCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myCity = (prefs.getString('myCity') ?? 'нет данных');
    });
  }

  final Stream<QuerySnapshot> notesSrteam = FirebaseFirestore.instance
      .collection('notes')
      .orderBy('passangerPrice')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final freeNotesScreenModel = FreeNotesController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: FittedBox(
          child: Text(
            'Заявки в г. $myCity:',
            style: const TextStyle(),
          ),
        ),
        actions: [
          TextButton(
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
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: freeNotesScreenModel.notesSrteam,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      var valuesList = data.values.toList();

                      var uidPassanger = data.entries
                          .firstWhere((entry) => entry.key == 'uidPassanger')
                          .value;

                      var uidNote = data.entries
                          .firstWhere((entry) => entry.key == 'uidNote')
                          .value;

                      var uidDriverToChat = data.entries
                          .firstWhere((entry) => entry.key == 'uidDriverToChat')
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
                          .firstWhere((entry) => entry.key == 'childrenCount')
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
                          .firstWhere((entry) => entry.key == 'passangerPrice')
                          .value;

                      var index = 0;
                      return SingleChildScrollView(
                        child: Dismissible(
                          key: Key(snapshot.data!.docs[index].id),
                          child: Provider<Note>(
                            create: (context) => Note(
                                uidPassanger: uidPassanger,
                                uidNote: uidNote,
                                uidDriverToChat: uidDriverToChat,
                                adressFrom: adressFrom,
                                adressToGo: adressToGo,
                                isChildren: isChildren,
                                childrenCount: childrenCount,
                                isAnimals: isAnimals,
                                whatAnimal: whatAnimal,
                                remark: remark,
                                passangerPrice: passangerPrice),
                            builder: (context, child) => Card(
                              color: Colors.yellow.shade300,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('uidNote - $uidNote '),
                                    // Text('uidPassanger - $uidPassanger '),
                                    // Text('uidDriver - $uidDriverToChat '),
                                    Text('Адрес подачи - $adressFrom'),
                                    Text('Конечный адрес - $adressToGo'),
                                    Text('Дети до 7 лет - $childrenCount'),
                                    Text('Звери - $whatAnimal'),
                                    Text('Примечания - $remark'),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 163, 221, 192),
                                            height: 17,
                                            child: Text(
                                                'Цена пассажира - $passangerPrice руб.'),
                                          ),
                                          TextButton(
                                            child: const Text('Взять в работу'),
                                            onPressed: () async {
                                              var driverUidToChat = FirebaseAuth
                                                  .instance.currentUser?.uid;

                                              await FirebaseFirestore.instance
                                                  .collection('notes')
                                                  .doc(uidNote)
                                                  .update({
                                                'uidDriverToChat':
                                                    driverUidToChat
                                              });

                                              // await FirebaseFirestore.instance
                                              //     .collection('notes')
                                              //     .doc(uidNote)
                                              //     .collection('messages')
                                              //     .add({
                                              //   'ChatMessage': "Готов обсудить!"
                                              // });

                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NoteToChat(),
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
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // !!!!!!!!!!!!
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
