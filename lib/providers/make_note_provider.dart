import 'package:chat_taxi/domain/note.dart';
import 'package:chat_taxi/this_note_screen.dart';
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

  void saveNote(BuildContext context) async {
    final uidPassanger = FirebaseAuth.instance.currentUser?.uid;
    final uidNote = uidPassanger;

    var idPassanger = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance.collection("notes").doc(idPassanger).set({
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
        builder: (context) => const ThisNotesScreenWidget(),
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
