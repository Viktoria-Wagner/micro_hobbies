import 'package:flutter/material.dart';
import 'package:new_micro_hobbies/Theme/app_theme.dart';
import 'package:new_micro_hobbies/providers/hobby_provider.dart';
import 'Home/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    //MultiProvider erlaubt es uns, beliebig viele providers zu starten
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => HobbyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<ThemeProvider>();

    //allgemeines Design für die App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MicroHobbies',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundPastel,
        useMaterial3: true,
      ),
      home: const HomeScreen(), //Aufruf des Startbildschirms
    );
  }
}
