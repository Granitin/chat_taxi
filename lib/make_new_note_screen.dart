import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chat_taxi/main_screen.dart';
import 'package:chat_taxi/providers/make_note_provider.dart';
import 'package:flutter/material.dart';

class NoteFormWidget extends StatefulWidget {
  const NoteFormWidget({Key? key}) : super(key: key);

  @override
  State<NoteFormWidget> createState() => _NoteFormWidgetState();
}

class _NoteFormWidgetState extends State<NoteFormWidget> {
  final _model = NoteFormModel();

  @override
  Widget build(BuildContext context) {
    return NoteFormModelProvider(
      model: _model,
      child: const _NoteFormBody(),
    );
  }
}

class _NoteFormBody extends StatelessWidget {
  const _NoteFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade300,
      appBar: AppBar(
        title: const Text('Создать заявку'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _AdressFromForm(),
              const SizedBox(height: 5),
              const _AdressToGoForm(),
              const SizedBox(height: 5),
              const _ChildrenForm(),
              const SizedBox(height: 5),
              const _AnimalForm(),
              const SizedBox(height: 5),
              const _Remark(),
              const SizedBox(height: 5),
              const _PassangerPrice(),
              const SizedBox(height: 5),
              const MakeNoteButton(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.yellow),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                },
                child: const Text('Главный экран'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdressFromForm extends StatelessWidget {
  const _AdressFromForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Откуда поедем?',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.adressFrom = value,
      ),
    );
  }
}

class _AdressToGoForm extends StatelessWidget {
  const _AdressToGoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Куда поедем?',
          border: OutlineInputBorder(),
          isDense: true,
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.adressToGo = value,
      ),
    );
  }
}

class _ChildrenForm extends StatefulWidget {
  const _ChildrenForm({Key? key}) : super(key: key);

  @override
  State<_ChildrenForm> createState() => _ChildrenFormState();
}

class _ChildrenFormState extends State<_ChildrenForm> {
  bool isChildren = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
            value: isChildren,
            onChanged: (bool? value) {
              setState(
                () {
                  isChildren = value!;
                },
              );
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
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 13),
                isDense: true,
                hintText: 'Сколько?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              onChanged: (value) => NoteFormModelProvider.of(context)
                  ?.model
                  .childrenCount = value,
            ),
          ),
        ),
      ],
    );
  }
}

class _AnimalForm extends StatefulWidget {
  const _AnimalForm({Key? key}) : super(key: key);

  @override
  State<_AnimalForm> createState() => _AnimalFormState();
}

class _AnimalFormState extends State<_AnimalForm> {
  bool isAnimals = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
              value: isAnimals,
              onChanged: (bool? value) {
                setState(() {
                  isAnimals = value!;
                });
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
        ),
      ],
    );
  }
}

class _Remark extends StatelessWidget {
  const _Remark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          isDense: true,
          hintText: 'Примечания (заезды, нужно купить и привезти и т.п.)',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) =>
            NoteFormModelProvider.of(context)?.model.remark = value,
      ),
    );
  }
}

class _PassangerPrice extends StatelessWidget {
  const _PassangerPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintStyle: TextStyle(fontSize: 13),
          hintText: 'Предложите свою цену',
          border: OutlineInputBorder(),
          isDense: true,
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
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.yellow),
      ),
      onPressed: () {
        NoteFormModelProvider.of(context)?.model.saveNote(context);
        AssetsAudioPlayer.playAndForget(
          Audio('assets/sounds/ding.mp3'),
        );
      },
      child: const Text('Отправить заявку'),
    );
  }
}
