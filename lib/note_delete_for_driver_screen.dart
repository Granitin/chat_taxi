import 'package:flutter/material.dart';

class NoteDeleteForDriverScreen extends StatelessWidget {
  const NoteDeleteForDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const Text('ЗАЯВКА УДАЛЕНА'),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Список свободный заявок'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Главный экран'),
            ),
          ],
        ),
      )),
    );
  }
}
