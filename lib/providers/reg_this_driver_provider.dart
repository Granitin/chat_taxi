import 'package:chat_taxi/domain/driver_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> regThisDriver(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.signInAnonymously();
    } catch (error) {
      print('error');
    }

    final uidDriver = FirebaseAuth.instance.currentUser?.uid;
    final thisDriver = Driver(
        uidDriver: uidDriver ?? '',
        phoneNumberDriver: phoneNumberDriver,
        whatCarDriver: whatCarDriver,
        colorCarDriver: colorCarDriver,
        numberCarDriver: numberCarDriver);

    final driverToJson = thisDriver.toJson();

    final thisDriverUid = FirebaseAuth.instance.currentUser?.uid;

    // FirebaseFirestore.instance
    //     .collection("drivers")
    //     .doc(thisDriverUid)
    //     .set({"driver": driverToJson});

    FirebaseFirestore.instance.collection("drivers").doc(thisDriverUid).set({
      'uidDriver': uidDriver,
      'phoneNumberDriver': phoneNumberDriver,
      'whatCarDriver': whatCarDriver,
      'colorCarDriver': colorCarDriver,
      'numberCarDriver': numberCarDriver,
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uidDriver', uidDriver ?? '');
    prefs.setString('phoneNumberDriver', phoneNumberDriver);
    prefs.setString('whatCarDriver', whatCarDriver);
    prefs.setString('colorCarDriver', colorCarDriver);
    prefs.setString('numberCarDriver', numberCarDriver);

    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const FreeNotesScreen()),
    //   (Route<dynamic> route) => false,
    // );
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
