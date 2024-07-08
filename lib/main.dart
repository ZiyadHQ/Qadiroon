import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/start_widget.dart';
import 'firebase_options.dart';



void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartScreen(),
    );
  }
}
