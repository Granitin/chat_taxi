import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCityModel {
  var myCity = '';

  void readMyCity(BuildContext context) async {
    final cityPrefs = await SharedPreferences.getInstance();
    var myCity = (cityPrefs.getString('myCity') ?? 'нет данных');
  }
}

class MyCityProvider extends InheritedWidget {
  final MyCityModel model;
  const MyCityProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static MyCityProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyCityProvider>();
  }

  @override
  bool updateShouldNotify(MyCityProvider oldWidget) {
    return true;
  }
}
