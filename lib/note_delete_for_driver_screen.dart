import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/main_screen.dart';
import 'package:flutter/material.dart';

class NoteDeleteForDriverScreen extends StatelessWidget {
  const NoteDeleteForDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber,
              size: 50,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '!!! ---- ЗАЯВКА БЫЛА УДАЛЕНА ---- !!!',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.darkColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FreeNotesScreen(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Свободные заявки'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.darkColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
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
              child: const Text('Главный экран'),
            ),
          ],
        ),
      )),
    );
  }
}
