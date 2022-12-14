import 'package:chat_taxi/main_screen.dart';
import 'package:flutter/material.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Правила ЧАТ-ТАКСИ'),
        backgroundColor: AppColors.darkColor,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.yellow[200],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Правила приложения ЧАТ-ТАКСИ:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('1'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          'Пассажиру не требуется регистрироваться. Не надо вводить ни телефон, ни номер карты - ничего.'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('2'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          'Пассажир создает заявку, где требуется указать: \n- адрес подачи, \n- конечный адрес, \n- количество детей возрастом до 7 лет, \n- животных (если перевозятся), \n- примечания (багаж, заезды, купить и привезти, отвезти и т.п.), \n- предложить свою цену поездки (не обязательно).'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('3'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child:
                          Text('Пассажир может создавать только одну заявку.'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('4'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          'Водителю для работы в приложении необходимо пройти регистрацию и указать: \n- свой номер телефона, \n- марку автомобиля, \n- цвет автомобиля, \n- гос.номер автомобиля.'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('5'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          'Зарегистрированные водители могут видеть список свободных заявок, размещенных пассажирами, и могут общаться с пассажирами в чате по конкретной заявке, обсуждая условия поездки.'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('6'),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                          'Пользователи используют приложение на свой страх и риск. Разработчик не несет ответственности за действия пользователей.'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
