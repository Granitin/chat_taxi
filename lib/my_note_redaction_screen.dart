import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/providers/make_note_provider.dart';
import 'package:flutter/material.dart';

class NoteRedactionFormWidget extends StatefulWidget {
  const NoteRedactionFormWidget({Key? key}) : super(key: key);

  @override
  State<NoteRedactionFormWidget> createState() =>
      _NoteRedactionFormWidgetState();
}

class _NoteRedactionFormWidgetState extends State<NoteRedactionFormWidget> {
  final _model = NoteFormModel();

  @override
  Widget build(BuildContext context) {
    return NoteFormModelProvider(
      model: _model,
      child: const _NoteRedactionFormBody(),
    );
  }
}

class _NoteRedactionFormBody extends StatefulWidget {
  const _NoteRedactionFormBody({Key? key}) : super(key: key);

  @override
  State<_NoteRedactionFormBody> createState() => _NoteRedactionFormBodyState();
}

class _NoteRedactionFormBodyState extends State<_NoteRedactionFormBody> {
  // String passangerPrice = '';

  TextEditingController controllerPrice = TextEditingController();

  @override
  void initState() {
    controllerPrice = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final infoMyNote = ModalRoute.of(context)?.settings.arguments as List;

    final uidNote = infoMyNote.elementAt(0);
    final uidPassanger = infoMyNote.elementAt(1);
    final uidDriverToChat = infoMyNote.elementAt(2);
    final adressFrom = infoMyNote.elementAt(3);
    final adressToGo = infoMyNote.elementAt(4);
    final childrenCount = infoMyNote.elementAt(5);
    final whatAnimal = infoMyNote.elementAt(6);
    final remark = infoMyNote.elementAt(7);
    var passangerPrice = infoMyNote.elementAt(8);

    bool isChildren = false;
    bool isAnimals = false;

    controllerPrice.text = passangerPrice;

    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Редактирование заявки'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: adressFrom,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 13),
                    hintText: 'Откуда поедем?',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (value) => NoteFormModelProvider.of(context)
                      ?.model
                      .adressFrom = value,
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: adressToGo,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 13),
                    hintText: 'Куда поедем?',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (value) => NoteFormModelProvider.of(context)
                      ?.model
                      .adressToGo = value,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                      value: isChildren,
                      onChanged: (bool? value) {
                        isChildren = (NoteFormModelProvider.of(context)
                            ?.model
                            .isChildren = value!)!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                    child: Text(
                      'Дети до 7 лет?',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 100,
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        initialValue: childrenCount,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 13),
                          isDense: true,
                          hintText: 'Сколько?',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) => NoteFormModelProvider.of(context)
                            ?.model
                            .childrenCount = value,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                        value: isAnimals,
                        onChanged: (bool? value) {
                          isAnimals = (NoteFormModelProvider.of(context)
                              ?.model
                              .isAnimals = value!)!;
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                    child: Text(
                      'Есть животные?',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        initialValue: whatAnimal,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(fontSize: 13),
                          isDense: true,
                          hintText: 'Что за животное?',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) => NoteFormModelProvider.of(context)
                            ?.model
                            .whatAnimal = value,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 40,
                child: TextFormField(
                  initialValue: remark,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 13),
                    isDense: true,
                    hintText:
                        'Примечания (заезды, нужно купить и привезти и т.п.)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      NoteFormModelProvider.of(context)?.model.remark = value,
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 40,
                child: TextFormField(
                  controller: controllerPrice,

                  onSaved: (value) => setState(() {
                    controllerPrice.text = passangerPrice;
                    NoteFormModelProvider.of(context)?.model.passangerPrice =
                        value!;
                  }),
                  onChanged: (String value) => setState(() {
                    controllerPrice.text = passangerPrice;
                    NoteFormModelProvider.of(context)?.model.passangerPrice =
                        value;
                  }),
                  // initialValue: passangerPrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 13),
                    hintText: '$passangerPrice',
                    border: const OutlineInputBorder(),
                    // isDense: true,
                  ),
                  // onChanged: (value) => NoteFormModelProvider.of(context)
                  //     ?.model
                  //     .passangerPrice = value,
                ),
              ),
              // const SizedBox(height: 10),
              const MakeNoteButton(),
              // const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.yellow),
                ),
                child: const Text("Главное меню"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MakeNoteButton extends StatelessWidget {
  const MakeNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          NoteFormModelProvider.of(context)?.model.saveNote(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.yellow),
      ),
      child: const Text('Отправить заявку'),
    );
  }
}
