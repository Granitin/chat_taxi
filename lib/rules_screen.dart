import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Правила Chat-Taxi'),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              Text('Правила использования приложения Chat-Taxi'),
              SizedBox(
                height: 10,
              ),
              Text('Никаких правил'),
            ],
          ),
        ),
      ),
    );
  }
}
