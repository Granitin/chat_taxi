import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/providers/reg_this_driver_provider.dart';
import 'package:flutter/material.dart';

class RegThisDriverWidget extends StatefulWidget {
  const RegThisDriverWidget({Key? key}) : super(key: key);

  @override
  State<RegThisDriverWidget> createState() => _RegThisDriverWidgetState();
}

class _RegThisDriverWidgetState extends State<RegThisDriverWidget> {
  final _modelDriver = DriverFormModel();

  @override
  Widget build(BuildContext context) {
    return RegDriverProvider(
      model: _modelDriver,
      child: const RegThisDriverFormBody(),
    );
  }
}

class RegThisDriverFormBody extends StatelessWidget {
  const RegThisDriverFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text('Регистрация водителя'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            _PhoneDriver(),
            SizedBox(height: 30),
            _WhatCarDriver(),
            SizedBox(height: 30),
            _ColorCarDriver(),
            SizedBox(height: 30),
            _NumberCarDriver(),
            SizedBox(height: 30),
            RegDriverButton(),
          ],
        ),
      ),
    );
  }
}

class _PhoneDriver extends StatelessWidget {
  const _PhoneDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Введите номер телефона',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            RegDriverProvider.of(context)?.model.phoneNumberDriver = value,
      ),
    );
  }
}

class _WhatCarDriver extends StatelessWidget {
  const _WhatCarDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Введите марку машины',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            RegDriverProvider.of(context)?.model.whatCarDriver = value,
      ),
    );
  }
}

class _ColorCarDriver extends StatelessWidget {
  const _ColorCarDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Введите цвет машины',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            RegDriverProvider.of(context)?.model.colorCarDriver = value,
      ),
    );
  }
}

class _NumberCarDriver extends StatelessWidget {
  const _NumberCarDriver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Введите номер машины',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            RegDriverProvider.of(context)?.model.numberCarDriver = value,
      ),
    );
  }
}

class RegDriverButton extends StatelessWidget {
  const RegDriverButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        RegDriverProvider.of(context)?.model.regThisDriver(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FreeNotesScreen(),
          ),
        );
      },
      child: const Text('Зарегиться'),
    );
  }
}
