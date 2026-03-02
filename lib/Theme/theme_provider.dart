import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  //Globale statische Variablen. So kann unsere app_theme.dart
  // später blitzschnell darauf zugreifen, ohne komplizierten Code.
  static bool isDark = false;
  static double scale = 1.0;

  //Die aktuellen Werte für die Schalter in der UI
  String currentLanguage = 'Deutsch';
  String currentFontSize = 'Mittel';


  void toggleDarkMode(bool value) {
    isDark = value;
    notifyListeners(); //Sendet das Signal an die ganze App: "Neu zeichnen!"
  }

  void setFontSize(String size) {
    currentFontSize = size;

    if (size == 'Klein') {
      scale = 0.85; // 15% kleiner
    } else if (size == 'Mittel') {
      scale = 1.0;  // Normal
    } else if (size == 'Groß') {
      scale = 1.2;  // 20% größer
    }

    notifyListeners(); //Signal senden!
  }

  void setLanguage(String lang) {
    currentLanguage = lang;
    notifyListeners(); //Signal senden!
  }
}