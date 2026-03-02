import 'package:flutter/material.dart';
import 'package:new_micro_hobbies/Theme/app_theme.dart';
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
        scaffoldBackgroundColor: AppColors.backgroundPastel,
        useMaterial3: true,//package
      ),
      home: const HomeScreen(),//Aufruf des Startbildschirms
    );
  }
}