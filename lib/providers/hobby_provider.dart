import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hobby_data.dart';

class HobbyProvider extends ChangeNotifier {
  // Unsere internen Listen
  List<Hobby> _savedHobbies = [];
  List<Hobby> _completedHobbies = [];

  // Öffentlicher Zugriff für die UI (nur lesen)
  List<Hobby> get savedHobbies => _savedHobbies;
  List<Hobby> get completedHobbies => _completedHobbies;

  HobbyProvider() {
    _loadFromPrefs();
  }

  //Laden beim Start
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Wir laden nur die simplen Text-Listen (die Titel)
    final savedTitles = prefs.getStringList('savedHobbies') ?? [];
    final completedTitles = prefs.getStringList('completedHobbies') ?? [];

    // Wir suchen in der Datenbank nach den Hobbys, die diese Titel haben
    _savedHobbies = HobbyDatabase.dummyHobbies
        .where((hobby) => savedTitles.contains(hobby.title))
        .toList();

    _completedHobbies = HobbyDatabase.dummyHobbies
        .where((hobby) => completedTitles.contains(hobby.title))
        .toList();

    notifyListeners(); // UI aktualisieren!
  }

  // Speichern
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Wir verwandeln die komplexen Hobbys in einfache Text-Listen (nur Titel)
    final savedTitles = _savedHobbies.map((h) => h.title).toList();
    final completedTitles = _completedHobbies.map((h) => h.title).toList();

    await prefs.setStringList('savedHobbies', savedTitles);
    await prefs.setStringList('completedHobbies', completedTitles);
  }

  void addSavedHobby(Hobby hobby) {
    // Nur hinzufügen, wenn es noch nicht in der Liste ist
    if (!_savedHobbies.any((h) => h.title == hobby.title)) {
      _savedHobbies.add(hobby);
      _saveToPrefs();
      notifyListeners();
    }
  }

  void removeSavedHobby(Hobby hobby) {
    _savedHobbies.removeWhere((h) => h.title == hobby.title);
    _saveToPrefs();
    notifyListeners();
  }

  void addCompletedHobby(Hobby hobby) {
    if (!_completedHobbies.any((h) => h.title == hobby.title)) {
      _completedHobbies.add(hobby);
      removeSavedHobby(hobby); // Wenn es erledigt ist, fliegt es aus den Gemerkten raus
      _saveToPrefs();
      notifyListeners();
    }
  }

  // Die Funktion für deinen neuen roten Reset-Button!
  Future<void> resetProgress() async {
    _savedHobbies.clear();
    _completedHobbies.clear();
    await _saveToPrefs();
    notifyListeners();
  }
}