import 'package:chat_taxi/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.yellowColor,
      body: SafeArea(
        child: SelectCityBody(),
      ),
    );
  }
}

class SelectCityBody extends StatefulWidget {
  const SelectCityBody({super.key});

  @override
  State<SelectCityBody> createState() => _SelectCityBodyState();
}

class _SelectCityBodyState extends State<SelectCityBody> {
  String? selectedCity;
  String? myCity;
  String? myCityFromPrefs;

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
      value: 'Васюки',
      child: Text('Васюки'),
    ),
    const DropdownMenuItem(
      value: 'Нью-Васюки',
      child: Text('Нью-Васюки'),
    ),
    const DropdownMenuItem(
      value: 'Москва',
      child: Text('Москва'),
    ),
    const DropdownMenuItem(
      value: 'Улан-Удэ',
      child: Text('Улан-Удэ'),
    ),
  ];

  void dropdownCitiesCallback(String? selectedCity) {
    if (selectedCity is String) {
      setState(() {
        myCity = selectedCity;
      });
    }
  }

  Future<void> saveMyCity() async {
    final prefsOfMyCities = await SharedPreferences.getInstance();
    prefsOfMyCities.setString('myCity', myCity ?? '');
  }

  Future<void> readMyCity() async {
    final prefsOfMyCity = await SharedPreferences.getInstance();
    var myCityFromPrefs = prefsOfMyCity.get('myCity').toString();
    debugPrint(myCityFromPrefs);
  }

  @override
  void initState() {
    super.initState();
    _loadMyCity();
    setState(() {});
  }

  Future<void> _loadMyCity() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myCity = (prefs.getString('myCity'));
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      dropdownCitiesCallback(selectedCity = myCity);
    });

    if (myCity == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Добро пожаловать в приложение',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const Text(
              'ЧАТ-ТАКСИ!',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20),
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset(
                fit: BoxFit.fill,
                'assets/lottie/taxi.json',
              ),
            ),
            const Text('Для продолжения работы, выберите город:'),
            DropdownButton(
                dropdownColor: Colors.yellow,
                iconEnabledColor: AppColors.darkColor,
                hint: const Text('Выбрать город'),
                items: cities,
                // value: myCity,
                onChanged: dropdownCitiesCallback),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.darkColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow),
              ),
              onPressed: () {
                if (myCity == null) {
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
                  saveMyCity();
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
      );
    } else {
      if (myCity!.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Добро пожаловать в приложение',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const Text(
                'ЧАТ-ТАКСИ!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 300,
                width: 300,
                child:
                    Lottie.asset('assets/lottie/taxi.json', fit: BoxFit.fill),
              ),
              SizedBox(
                height: 300,
                child: AlertDialog(
                  elevation: 100,
                  backgroundColor: Colors.lime[300],
                  title: Column(
                    children: [
                      const Text('Вы в городе'),
                      Text(
                        '$myCity?',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                  content: Column(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.darkColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.yellow),
                        ),
                        onPressed: () => saveMyCity().then(
                          (value) => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => const MainScreen()),
                            ),
                          ),
                        ),
                        child: const Text('ДА'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton(
                              dropdownColor: AppColors.yellowColor,
                              iconEnabledColor: AppColors.darkColor,
                              hint: const Text('Выбрать город'),
                              items: cities,
                              // value: myCity,
                              onChanged: dropdownCitiesCallback),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    }
  }
}
