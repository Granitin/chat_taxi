import 'package:chat_taxi/main_screen.dart';
import 'package:flutter/material.dart';

GlobalKey myCity = GlobalKey();

class ChooseCityScreen extends StatelessWidget {
  const ChooseCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.yellowColor,
      body: SafeArea(
        child: ChooseCityBody(),
      ),
    );
  }
}

class ChooseCityBody extends StatefulWidget {
  const ChooseCityBody({super.key});

  @override
  State<ChooseCityBody> createState() => _ChooseCityBodyState();
}

class _ChooseCityBodyState extends State<ChooseCityBody> {
  String? selectedCity;
  String? _myCity;

  List<DropdownMenuItem<String>> cities = [
    const DropdownMenuItem(
      value: 'Кострома',
      child: Text('Кострома'),
    ),
    const DropdownMenuItem(
      value: 'Иваново',
      child: Text('Иваново'),
    ),
    const DropdownMenuItem(
      value: 'Москва',
      child: Text('Москва'),
    ),
    const DropdownMenuItem(
      value: 'Санкт-Петербург',
      child: Text('Санкт-Петербург'),
    ),
    const DropdownMenuItem(
      value: 'Хабаровск',
      child: Text('Хабаровск'),
    ),
    const DropdownMenuItem(
      value: 'Ярославль',
      child: Text('Ярославль'),
    ),
    const DropdownMenuItem(
      value: 'Улан-Удэ',
      child: Text('Улан-Удэ'),
    ),
    const DropdownMenuItem(
      value: 'Кемерово',
      child: Text('Кемерово'),
    ),
    const DropdownMenuItem(
      value: 'Норильск',
      child: Text('Норильск'),
    ),
    const DropdownMenuItem(
      value: 'Васюки',
      child: Text('Васюки'),
    ),
    const DropdownMenuItem(
      value: 'Нью-Васюки',
      child: Text('Нью-Васюки'),
    ),
  ];

  void dropdownCitiesCallback(String? selectedCity) {
    if (selectedCity is String) {
      setState(() {
        _myCity = selectedCity;
        print(_myCity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellowColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Добро пожаловать в приложение'),
            const Text('ЧАТ-ТАКСИ!'),
            const SizedBox(
              height: 25,
            ),
            const Text('Для продолжения работы, выберите город:'),
            DropdownButton(
                dropdownColor: Colors.yellow,
                iconEnabledColor: AppColors.darkColor,
                hint: const Text('Выберите город'),
                items: cities,
                value: _myCity,
                onChanged: dropdownCitiesCallback),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.darkColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                if (_myCity == null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.yellow,
                          title: const Text(
                            'Необходимо выбрать город',
                            textAlign: TextAlign.center,
                          ),
                          content: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Выбрать город'),
                          ),
                        );
                      });
                } else {
                  _myCity = _myCity;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                  );
                }
              },
              child: const Text('Продолжить'),
            ),
          ],
        ),
      ),
    );
  }
}
