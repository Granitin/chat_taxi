import 'package:chat_taxi/domain/note.dart';
import 'package:chat_taxi/my_note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NoteFormModel {
  var uidPassanger = "";
  var uidNote = "";
  var uidDriverToChat = "";
  var adressFrom = "";
  var adressToGo = "";
  var isChildren = false;
  var childrenCount = "";
  var isAnimals = false;
  var whatAnimal = "";
  var remark = "";
  var passangerPrice = "";
  Note note = Note(
    uidPassanger: "",
    uidNote: "",
    uidDriverToChat: "",
    adressFrom: "",
    adressToGo: "",
    isChildren: false,
    childrenCount: "",
    isAnimals: false,
    whatAnimal: "",
    remark: "",
    passangerPrice: "",
  );

  void getMyNoteInfo(BuildContext context) async {
    final idNote = FirebaseAuth.instance.currentUser?.uid;
    final docRef = FirebaseFirestore.instance.collection("notes").doc(idNote);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        var uidPassanger = data.entries
            .firstWhere((entry) => entry.key == 'uidPassanger')
            .value;

        var uidNote =
            data.entries.firstWhere((entry) => entry.key == 'uidNote').value;

        var uidDriverToChat = data.entries
            .firstWhere((entry) => entry.key == 'uidDriverToChat')
            .value;

        var adressFrom =
            data.entries.firstWhere((entry) => entry.key == 'adressFrom').value;

        var adressToGo =
            data.entries.firstWhere((entry) => entry.key == 'adressToGo').value;

        var isChildren =
            data.entries.firstWhere((entry) => entry.key == 'isChildren').value;

        var childrenCount = data.entries
            .firstWhere((entry) => entry.key == 'childrenCount')
            .value;

        var isAnimals =
            data.entries.firstWhere((entry) => entry.key == 'isAnimals').value;

        var whatAnimal =
            data.entries.firstWhere((entry) => entry.key == 'whatAnimal').value;

        var remark =
            data.entries.firstWhere((entry) => entry.key == 'remark').value;

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
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void saveNote(BuildContext context) async {
    final uidPassanger = FirebaseAuth.instance.currentUser?.uid;
    final uidNote = uidPassanger;

    FirebaseFirestore.instance.collection("notes").doc(uidPassanger).set({
      "uidPassanger": uidPassanger,
      "uidNote": uidNote,
      "uidDriverToChat": uidDriverToChat,
      'adressFrom': adressFrom,
      "adressToGo": adressToGo,
      "isChildren": isChildren,
      "childrenCount": childrenCount,
      "isAnimals": isAnimals,
      "whatAnimal": whatAnimal,
      "remark": remark,
      "passangerPrice": passangerPrice,
    });

    Navigator.pushReplacement(
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
}

class NoteFormModelProvider extends InheritedWidget {
  final NoteFormModel model;
  const NoteFormModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static NoteFormModelProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NoteFormModelProvider>();
  }

  @override
  bool updateShouldNotify(NoteFormModelProvider oldWidget) {
    return true;
  }
}
