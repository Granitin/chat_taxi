import 'package:chat_taxi/domain/driver_info.dart';
import 'package:chat_taxi/registration_this_driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverFormModel {
  var uidDriver = '';
  var phoneNumberDriver = '';
  var whatCarDriver = '';
  var colorCarDriver = '';
  var numberCarDriver = '';
  Driver thisDriver = Driver(
    uidDriver: '',
    phoneNumberDriver: '',
    whatCarDriver: '',
    colorCarDriver: '',
    numberCarDriver: '',
  );

  void regThisDriver(BuildContext context) {
    final uidDriver = FirebaseAuth.instance.currentUser?.uid;
    final thisDriver = Driver(
        uidDriver: uidDriver!,
        phoneNumberDriver: phoneNumberDriver,
        whatCarDriver: whatCarDriver,
        colorCarDriver: colorCarDriver,
        numberCarDriver: numberCarDriver);

    final driverToJson = thisDriver.toJson();

    final thisDriverUid = FirebaseAuth.instance.currentUser?.uid;

    FirebaseFirestore.instance
        .collection("drivers")
        .doc(thisDriverUid)
        .set({"driver": driverToJson});

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegThisDriverWidget(),
      ),
    );
  }
}

class RegDriverProvider extends InheritedWidget {
  final DriverFormModel model;
  const RegDriverProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static RegDriverProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RegDriverProvider>();
  }

  @override
  bool updateShouldNotify(RegDriverProvider oldWidget) {
    return true;
  }
}
