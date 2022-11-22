import 'package:chat_taxi/free_notes_screen.dart';
import 'package:chat_taxi/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/')
      //     return MaterialPageRoute(builder: (_) => MainScreen());
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           FreeNotesScreen()); // you can do this in `onUnknownRoute` too
      // },
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MainScreen(),
      //   '/free_notes': (context) => const FreeNotesScreen(),
      // },
    );
  }
}
