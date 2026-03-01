import 'package:flutter/material.dart';
import 'Home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //allgemeines Design für die App
    return MaterialApp(
      title: 'MicroHobbies',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFEAD1),
        useMaterial3: true,//package
      ),
      home: const HomeScreen(),//Aufruf des Startbildschirms
    );
  }
}