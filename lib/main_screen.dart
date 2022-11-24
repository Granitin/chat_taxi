// ignore_for_file: avoid_print

import 'package:chat_taxi/choose_city_screen.dart';
import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/make_new_note_screen.dart';
import 'package:chat_taxi/my_note_screen.dart';
import 'package:chat_taxi/registration_this_driver.dart';
import 'package:chat_taxi/rules_screen.dart';
import 'package:chat_taxi/write_developer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class MyNoteController extends ChangeNotifier {
  void authThisPassanger() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      firebaseAuth.signInAnonymously();
    } catch (error) {
      print('error');
    }
  }
}

class AppColors {
  static const darkColor = Color.fromARGB(255, 61, 61, 61);
  static const yellowColor = Color.fromARGB(255, 238, 240, 145);
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MyNoteController(),
        child: const _MainScreenBody(),
      );
}

class _MainScreenBody extends StatelessWidget {
  const _MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myCity = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        centerTitle: true,
        title: const Text(
          'ЧАТ - ТАКСИ',
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.yellowColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.lime[300],
                    child: const PassangerSectionWidget(),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.amber[200],
                    child: const DriverSectionWidget(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.amber[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        RulesButtonWidget(),
                        SizedBox(
                          width: 10,
                        ),
                        WhriteDevMessageButtonWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PassangerSectionWidget extends StatelessWidget {
  const PassangerSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Раздел пассажира:',
          style: TextStyle(
            color: AppColors.darkColor,
            fontSize: 30,
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText(
              'создавай заявки без регистрации'.toUpperCase(),
              speed: const Duration(milliseconds: 100),
              textStyle: const TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MakeNewNoteButton(),
            MyNoteButton(),
          ],
        ),
        // const Divider(
        //   thickness: 2,
        //   color: AppColors.darkColor,
        // ),
      ],
    );
  }
}

class DriverSectionWidget extends StatelessWidget {
  const DriverSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            'Раздел водителя:',
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DriverRegistrationButton(),
          FreeNotesButton(),
          Text(
            'для просмотра необходимо \n зарегистрироваться водителем',
            style: TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          ThisDriverDataWidget(),
          DriverUnregisrationButton(),
        ],
      ),
    );
  }
}

class RulesButtonWidget extends StatelessWidget {
  const RulesButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Rules(),
          ),
        );
      },
      child: const Text(
        'Правила Chat-Taxi',
        style: TextStyle(
          color: AppColors.darkColor,
          fontSize: 10,
        ),
      ),
    );
  }
}

class WhriteDevMessageButtonWidget extends StatelessWidget {
  const WhriteDevMessageButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WriteDeveloperMessageWidget(),
          ),
        );
      },
      child: const Text(
        'Написать разработчику',
        style: TextStyle(
          color: AppColors.darkColor,
          fontSize: 10,
        ),
      ),
    );
  }
}

class MakeNewNoteButton extends StatelessWidget {
  const MakeNewNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainScreenModel = context.read<MyNoteController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.my_location,
          color: Colors.red,
        ),
        const SizedBox(
          width: 7,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
            foregroundColor: MaterialStateProperty.all(Colors.yellow),
          ),
          onPressed: () async {
            mainScreenModel.authThisPassanger();

            deleteMyNote();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteFormWidget(),
              ),
            );
          },
          child: const Text('Новая заявка'),
        ),
      ],
    );
  }
}

class MyNoteButton extends StatelessWidget {
  const MyNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.note_alt_outlined,
          color: Colors.blue,
        ),
        const SizedBox(
          width: 3,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
            foregroundColor: MaterialStateProperty.all(Colors.yellow),
          ),
          onPressed: () async {
            final idUser = FirebaseAuth.instance.currentUser?.uid;

            final docRef =
                FirebaseFirestore.instance.collection("notes").doc(idUser);

            docRef.get().then(
              (DocumentSnapshot doc) async {
                if (!doc.exists) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: const Text(
                            'У вас нет заявки',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            height: 100,
                            child: Column(
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
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Не хочу создавать заявку'),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  var data = doc.data() as Map<String, dynamic>;

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

                  print(data);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyNoteWidget(),
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
                }
              },
              onError: (e) => print("Error getting document: $e"),
            );
          },
          child: const Text('Моя заявка'),
        ),
      ],
    );
  }
}

class DriverRegistrationButton extends StatelessWidget {
  const DriverRegistrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
            foregroundColor: MaterialStateProperty.all(AppColors.yellowColor),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegThisDriverWidget(),
              ),
            );
          },
          child: Row(
            children: const [
              Icon(
                Icons.local_taxi,
                color: Colors.blue,
              ),
              SizedBox(
                width: 7,
              ),
              Text('Зарегистрироваться водителем'),
            ],
          ),
        ),
      ],
    );
  }
}

class FreeNotesButton extends StatelessWidget {
  const FreeNotesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
            foregroundColor: MaterialStateProperty.all(AppColors.yellowColor),
          ),
          onPressed: () {
            final idThisDriver = FirebaseAuth.instance.currentUser?.uid;
            final thisDriverInfo = FirebaseFirestore.instance
                .collection('drivers')
                .doc(idThisDriver);
            thisDriverInfo.get().then((DocumentSnapshot doc) async {
              if (!doc.exists) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.yellow,
                        title: const Text(
                          'Заявки могут видеть только водители',
                          textAlign: TextAlign.center,
                        ),
                        content: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RegThisDriverWidget(),
                              ),
                            );
                          },
                          child: const Text('Зарегистрироваться водителем'),
                        ),
                      );
                    });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FreeNotesScreen(),
                  ),
                );
              }
            });
          },
          child: Row(
            children: const [
              Icon(
                Icons.notes,
                color: Colors.green,
              ),
              SizedBox(
                width: 7,
              ),
              Text('Свободные заявки'),
            ],
          ),
        ),
      ],
    );
  }
}

class ThisDriverDataWidget extends StatefulWidget {
  const ThisDriverDataWidget({
    super.key,
  });

  @override
  State<ThisDriverDataWidget> createState() => _ThisDriverDataWidgetState();
}

class _ThisDriverDataWidgetState extends State<ThisDriverDataWidget> {
  String uidDriver = '';
  String phoneNumberDriver = '';
  String whatCarDriver = '';
  String colorCarDriver = '';
  String numberCarDriver = '';

  @override
  void initState() {
    super.initState();
    _loadDriverData();
    setState(() {});
  }

  Future<void> _loadDriverData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uidDriver = (prefs.getString('uidDriver') ?? 'нет данных');
      phoneNumberDriver =
          (prefs.getString('phoneNumberDriver') ?? 'нет данных');
      whatCarDriver = (prefs.getString('whatCarDriver') ?? 'нет данных');
      colorCarDriver = (prefs.getString('colorCarDriver') ?? 'нет данных');
      numberCarDriver = (prefs.getString('numberCarDriver') ?? 'нет данных');
    });
  }

  @override
  Widget build(BuildContext context) {
    final leftOffset = MediaQuery.of(context).size.width / 3.3.toDouble();
    return Padding(
      padding: EdgeInsets.only(left: leftOffset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Мои данные:',
            style: TextStyle(
                color: AppColors.darkColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(Icons.phone),
              const SizedBox(
                width: 5,
              ),
              Text(phoneNumberDriver),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.local_taxi,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(whatCarDriver),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.color_lens),
              const SizedBox(
                width: 5,
              ),
              Text(colorCarDriver),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.numbers),
              const SizedBox(
                width: 5,
              ),
              Text(numberCarDriver),
            ],
          ),
        ],
      ),
    );
  }
}

class DriverUnregisrationButton extends StatelessWidget {
  const DriverUnregisrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.red.shade400),
          ),
          onPressed: () async {
            final idDriverToDelete = FirebaseAuth.instance.currentUser?.uid;

            await FirebaseFirestore.instance
                .collection("drivers")
                .doc(idDriverToDelete)
                .delete();

            deleteThisDriverDataFromSharedPref();

            showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        backgroundColor: Colors.yellow,
                        title: Text('Удалился успешно',
                            textAlign: TextAlign.center),
                      );
                    })
                .timeout(
                  const Duration(seconds: 2),
                )
                .whenComplete(
                  () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  ),
                );
          },
          child: Row(
            children: const [
              Icon(
                Icons.delete_forever,
                color: Colors.black,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                'Не хочу больше быть водителем',
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> getInfoThisNote() async {
  final idNote = FirebaseAuth.instance.currentUser?.uid;
  final docRef = FirebaseFirestore.instance.collection("notes").doc(idNote);
  docRef.get().then(
    (DocumentSnapshot doc) {
      final dataMyNote = doc.data() as Map<String, dynamic>;
      print(dataMyNote);
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

Future<void> deleteThisDriverDataFromSharedPref() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('uidDriver');
  prefs.remove('phoneNumberDriver');
  prefs.remove('whatCarDriver');
  prefs.remove('colorCarDriver');
  prefs.remove('numberCarDriver');
}
