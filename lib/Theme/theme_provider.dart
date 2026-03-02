import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // NEU: Der Speicher-Import

class ThemeProvider extends ChangeNotifier {
  static bool isDark = false;
  static double scale = 1.0;

  String currentLanguage = 'Deutsch';
  String currentFontSize = 'Mittel';

  //Der Konstruktor. Wird automatisch 1x ausgeführt, wenn die App startet.
  ThemeProvider() {
    _loadFromPrefs();
  }

  //Einstellungen beim Start laden
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Liest die Werte aus. Wenn noch nichts gespeichert wurde (??), nimm den Standardwert.
    isDark = prefs.getBool('isDark') ?? false;
    currentLanguage = prefs.getString('language') ?? 'Deutsch';
    currentFontSize = prefs.getString('fontSize') ?? 'Mittel';

    // Skalierung passend zur geladenen Schriftgröße setzen
    if (currentFontSize == 'Klein') {
      scale = 0.85;
    } else if (currentFontSize == 'Groß') {
      scale = 1.2;
    } else {
      scale = 1.0;
    }

    notifyListeners();
  }

  void toggleDarkMode(bool value) async {
    isDark = value;
    notifyListeners();

    //Im Hintergrund speichern
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);
  }

  void setFontSize(String size) async {
    currentFontSize = size;

    if (size == 'Klein') {
      scale = 0.85;
    } else if (size == 'Mittel') {
      scale = 1.0;
    } else if (size == 'Groß') {
      scale = 1.2;
    }

    notifyListeners();

    //Im Hintergrund speichern
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('fontSize', size);
  }

  void setLanguage(String lang) async {
    currentLanguage = lang;
    notifyListeners();

    //Im Hintergrund speichern
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', lang);
  }
}