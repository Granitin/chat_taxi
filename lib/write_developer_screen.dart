import 'package:chat_taxi/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WriteDeveloperMessageWidget extends StatefulWidget {
  const WriteDeveloperMessageWidget({Key? key}) : super(key: key);

  @override
  State<WriteDeveloperMessageWidget> createState() =>
      _WriteDeveloperMessageWidgetState();
}

class _WriteDeveloperMessageWidgetState
    extends State<WriteDeveloperMessageWidget> {
  var devMessage;

  final userMessageId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
          title: const Text('Написать разработчику'),
          backgroundColor: Colors.black),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                cursorColor: Colors.black,
                controller: TextEditingController(text: ''),
                autofocus: true,
                maxLines: 7,
                decoration:
                    const InputDecoration(helperText: 'написать разработчику'),
                onChanged: (String value) {
                  devMessage = value;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.yellow),
                ),
                onPressed: () async {
                  if (devMessage == null || devMessage.toString().isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return const AlertDialog(
                            backgroundColor: Colors.yellow,
                            title: Text(
                              'Пустое сообщение не отправлять',
                              textAlign: TextAlign.center,
                            ),
                          );
                        });
                  } else if (devMessage.toString().length < 15) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).pop(true);
                          });
                          return const AlertDialog(
                            backgroundColor: Colors.yellow,
                            title: Text(
                              'Напиши побольше',
                              textAlign: TextAlign.center,
                            ),
                          );
                        });
                  } else {
                    FirebaseFirestore.instance
                        .collection('devMessages')
                        .doc(userMessageId)
                        .set({
                      'новое сообщение': devMessage,
                      'id пользователя': userMessageId,
                    });
                    showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                backgroundColor: Colors.yellow,
                                title: Text(
                                  'Сообщение отправлено',
                                  textAlign: TextAlign.center,
                                ),
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
                  }
                },
                child: const Text("Отправить сообщение"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
