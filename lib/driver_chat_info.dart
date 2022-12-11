import 'package:chat_taxi/main_screen.dart';
import 'package:flutter/material.dart';

class DriverChatInfo extends StatelessWidget {
  const DriverChatInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: const Text('Информация о водителе:'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.yellowColor,
          child: const Center(
            child: Text(
                'сюда можно вставить информацию о водителе:\n- общая информация,\n- фото машины,\n- отзывы,\n- еще что-нибудь.'),
          ),
        ),
      ),
    );
  }
}
