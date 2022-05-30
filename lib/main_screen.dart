// ignore_for_file: avoid_print

import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/make_new_note_screen.dart';
import 'package:chat_taxi/registration_this_driver.dart';
import 'package:chat_taxi/this_note_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreenController extends ChangeNotifier {
  void authThisPassanger() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      firebaseAuth.signInAnonymously();
    } catch (error) {
      print('error');
    }
  }

  Future<void> deleteThisNote() async {
    final idNoteToDelete = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection("notes")
        .doc(idNoteToDelete)
        .collection("messages")
        .get()
        .then((value) {
      for (var data in value.docs) {
        FirebaseFirestore.instance
            .collection("notes")
            .doc(idNoteToDelete)
            .collection("messages")
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

    print('заявка удалена');
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MainScreenController(),
        child: const _MainScreenBody(),
      );
}

class _MainScreenBody extends StatelessWidget {
  const _MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat-taxi'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: const [
                MakeNewNoteButton(),
                ThisNoteButton(),
                DeleteThisNoteButton(),
                SizedBox(
                  height: 130,
                ),
                DriverRegistrationButton(),
                FreeNotesButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MakeNewNoteButton extends StatelessWidget {
  const MakeNewNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainScreenModel = context.read<MainScreenController>();
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.orange),
      ),
      onPressed: () {
        mainScreenModel.authThisPassanger();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NoteFormWidget(),
          ),
        );
      },
      child: const Text('Новая заявка'),
    );
  }
}

class ThisNoteButton extends StatelessWidget {
  const ThisNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ThisNotesScreenWidget(),
          ),
        );
      },
      child: const Text('Моя заявка'),
    );
  }
}

class DeleteThisNoteButton extends StatelessWidget {
  const DeleteThisNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainScreenModel = context.read<MainScreenController>();
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400),
      ),
      onPressed: () {
        mainScreenModel.deleteThisNote();
      },
      child: const Text('Удалить мою заявку'),
    );
  }
}

class DriverRegistrationButton extends StatelessWidget {
  const DriverRegistrationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegThisDriverWidget(),
          ),
        );
      },
      child: const Text('Зарегиться водителем'),
    );
  }
}

class FreeNotesButton extends StatelessWidget {
  const FreeNotesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FreeNotesScreen(),
          ),
        );
      },
      child: const Text('Свободные заявки'),
    );
  }
}
