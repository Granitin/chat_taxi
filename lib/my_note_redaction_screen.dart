import 'package:flutter/material.dart';

import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/providers/make_note_provider.dart';

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
    final passangerPrice = infoMyNote.elementAt(8);

    bool isChildren = false;
    bool isAnimals = false;

    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: const Text('Редактирование заявки'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdressFromRedactionForm(
                adressFromRedaction: adressFrom,
              ),
              const SizedBox(height: 7),
              AdressToGoRedactionForm(adressToGo: adressToGo),
              const SizedBox(height: 7),
              Row(
                children: [
                  // Transform.scale(
                  //   scale: 0.8,
                  //   child: Checkbox(
                  //     value: isChildren,
                  //     onChanged: (bool? value) {
                  //       isChildren = (NoteFormModelProvider.of(context)
                  //           ?.model
                  //           .isChildren = value!)!;
                  //     },
                  //   ),
                  // ),
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
                    child: ChildrenCountRedaction(childrenCount: childrenCount),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  // Transform.scale(
                  //   scale: 0.8,
                  //   child: Checkbox(
                  //       value: isAnimals,
                  //       onChanged: (bool? value) {
                  //         isAnimals = (NoteFormModelProvider.of(context)
                  //             ?.model
                  //             .isAnimals = value!)!;
                  //       }),
                  // ),
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
                  WhatAnimalRedactionForm(whatAnimal: whatAnimal),
                ],
              ),
              const SizedBox(height: 7),
              RemarkRedactionForm(remark: remark),
              const SizedBox(height: 7),
              PassangerPriceRedactionForm(
                passangerPriceRedaction: passangerPrice,
              ),
              const MakeNoteButton(),
              const _GoMainScreenButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoMainScreenButton extends StatelessWidget {
  const _GoMainScreenButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
        foregroundColor: MaterialStateProperty.all(Colors.yellow),
      ),
      child: const Text("Главное меню"),
    );
  }
}

class AdressFromRedactionForm extends StatefulWidget {
  const AdressFromRedactionForm({
    Key? key,
    required this.adressFromRedaction,
  }) : super(key: key);

  final adressFromRedaction;

  @override
  State<AdressFromRedactionForm> createState() =>
      _AdressFromRedactionFormState();
}

class _AdressFromRedactionFormState extends State<AdressFromRedactionForm> {
  TextEditingController _adressFromController = TextEditingController();

  String get adressFromRedaction => widget.adressFromRedaction;

  @override
  void initState() {
    super.initState();

    _adressFromController = TextEditingController()
      ..addListener(() {})
      ..text = adressFromRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.adressFrom = adressFromRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _adressFromController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _adressFromController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          isDense: true,
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.adressFrom = value,
      ),
    );
  }
}

class AdressToGoRedactionForm extends StatefulWidget {
  const AdressToGoRedactionForm({
    Key? key,
    required this.adressToGo,
  }) : super(key: key);

  final adressToGo;

  @override
  State<AdressToGoRedactionForm> createState() =>
      _AdressToGoRedactionFormState();
}

class _AdressToGoRedactionFormState extends State<AdressToGoRedactionForm> {
  TextEditingController _adressToGoController = TextEditingController();
  String get adreassToGoRedaction => widget.adressToGo;

  @override
  void initState() {
    super.initState();

    _adressToGoController = TextEditingController()
      ..addListener(() {})
      ..text = adreassToGoRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.adressToGo = adreassToGoRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _adressToGoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _adressToGoController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Куда поедем?',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          isDense: true,
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.adressToGo = value,
      ),
    );
  }
}

class ChildrenCountRedaction extends StatefulWidget {
  const ChildrenCountRedaction({
    Key? key,
    required this.childrenCount,
  }) : super(key: key);

  final childrenCount;

  @override
  State<ChildrenCountRedaction> createState() => _ChildrenCountRedactionState();
}

class _ChildrenCountRedactionState extends State<ChildrenCountRedaction> {
  TextEditingController _childrenCountController = TextEditingController();

  String get childrenCountRedaction => widget.childrenCount;

  @override
  void initState() {
    super.initState();

    _childrenCountController = TextEditingController()
      ..addListener(() {})
      ..text = childrenCountRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.childrenCount =
        childrenCountRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _childrenCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _childrenCountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          isDense: true,
          hintText: 'Сколько?',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.childrenCount = value,
      ),
    );
  }
}

class WhatAnimalRedactionForm extends StatefulWidget {
  const WhatAnimalRedactionForm({
    Key? key,
    required this.whatAnimal,
  }) : super(key: key);

  final whatAnimal;

  @override
  State<WhatAnimalRedactionForm> createState() =>
      _WhatAnimalRedactionFormState();
}

class _WhatAnimalRedactionFormState extends State<WhatAnimalRedactionForm> {
  TextEditingController _whatAnimalController = TextEditingController();

  String get whatAnimalRedaction => widget.whatAnimal;

  @override
  void initState() {
    super.initState();

    _whatAnimalController = TextEditingController()
      ..addListener(() {})
      ..text = whatAnimalRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.whatAnimal = whatAnimalRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _whatAnimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: TextFormField(
          controller: _whatAnimalController,
          keyboardType: TextInputType.streetAddress,
          decoration: const InputDecoration(
            hintStyle: TextStyle(fontSize: 13),
            isDense: true,
            hintText: 'Что за животное?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          onChanged: (value) =>
              NoteFormModelProvider.of(context)?.model.whatAnimal = value,
        ),
      ),
    );
  }
}

class RemarkRedactionForm extends StatefulWidget {
  const RemarkRedactionForm({
    Key? key,
    required this.remark,
  }) : super(key: key);

  final remark;

  @override
  State<RemarkRedactionForm> createState() => _RemarkRedactionFormState();
}

class _RemarkRedactionFormState extends State<RemarkRedactionForm> {
  TextEditingController _remarkController = TextEditingController();

  String get remarkRedaction => widget.remark;

  @override
  void initState() {
    super.initState();

    _remarkController = TextEditingController()
      ..addListener(() {})
      ..text = remarkRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.remark = remarkRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _remarkController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          isDense: true,
          hintText: 'Примечания (заезды, нужно купить и привезти и т.п.)',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.remark = value,
      ),
    );
  }
}

class PassangerPriceRedactionForm extends StatefulWidget {
  const PassangerPriceRedactionForm({
    Key? key,
    required this.passangerPriceRedaction,
  }) : super(key: key);

  final passangerPriceRedaction;

  @override
  State<PassangerPriceRedactionForm> createState() =>
      _PassangerPriceRedactionFormState();
}

class _PassangerPriceRedactionFormState
    extends State<PassangerPriceRedactionForm> {
  TextEditingController _passangerPriceController = TextEditingController();

  String get _passangerPriceRedaction => widget.passangerPriceRedaction;

  @override
  void initState() {
    super.initState();

    _passangerPriceController = TextEditingController()
      ..addListener(() {})
      ..text = _passangerPriceRedaction;
  }

  @override
  void didChangeDependencies() {
    NoteFormModelProvider.of(context)?.model.passangerPrice =
        _passangerPriceRedaction;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _passangerPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _passangerPriceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          isDense: true,
          hintText: 'Ваша цена?',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.passangerPrice = value,
      ),
    );
  }
}

class MakeNoteButton extends StatelessWidget {
  const MakeNoteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        NoteFormModelProvider.of(context)?.model.saveNote(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.darkColor),
        foregroundColor: MaterialStateProperty.all(Colors.yellow),
      ),
      child: const Text('Отправить заявку'),
    );
  }
}
