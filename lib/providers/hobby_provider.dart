import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hobby_data.dart';

class HobbyProvider extends ChangeNotifier {
  // Unsere internen Listen
  List<Hobby> _savedHobbies = [];
  List<Hobby> _completedHobbies = [];
  String _activeDeck = 'Starterdeck';

  // Öffentlicher Zugriff für die UI (nur lesen)
  List<Hobby> get savedHobbies => _savedHobbies;

  List<Hobby> get completedHobbies => _completedHobbies;

  String get activeDeck => _activeDeck;

  // Diese Methode ändert das Deck und sagt der App: "Neu laden"
  void setActiveDeck(String deckName) {
    _activeDeck = deckName;
    notifyListeners();
  }

  // Dies ist die schlaue Liste, die der DiscoverScreen jetzt immer abruft!
  List<Hobby> get availableHobbies {
    // 1. Zuerst filtern wir alle Hobbys heraus, die der Nutzer schon gemerkt oder erledigt hat.
    // So sieht man keine Karte doppelt!
    var unseenHobbies = HobbyDatabase.dummyHobbies.where((hobby) {
      bool isSaved = _savedHobbies.any((h) => h.title == hobby.title);
      bool isCompleted = _completedHobbies.any((h) => h.title == hobby.title);
      return !isSaved && !isCompleted;
    }).toList();

    // 2. Jetzt filtern wir nach dem ausgewählten Deck
    switch (_activeDeck) {
      case 'Entspannt (Leicht)':
        return unseenHobbies
            .where((h) => h.difficulty.label == 'Entspannt')
            .toList();
      case 'Fokus (Mittel)':
        return unseenHobbies
            .where((h) => h.difficulty.label == 'Fokus')
            .toList();
      case 'Meister (Schwer)':
        return unseenHobbies
            .where((h) => h.difficulty.label == 'Anspruchsvoll')
            .toList();

      // Starterdeck und alle anderen (noch nicht implementierten) Kategorien
      // zeigen vorerst einfach alle ungelesenen Karten.
      case 'Starterdeck':
      default:
        return unseenHobbies;
    }
  }

  HobbyProvider() {
    _loadFromPrefs();
  }

  //Laden beim Start
  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    // Wir laden nur die simplen Text-Listen (die Titel)
    final savedTitles = prefs.getStringList('savedHobbies') ?? [];
    final completedTitles = prefs.getStringList('completedHobbies') ?? [];
    //aktives Deck laden
    _activeDeck = prefs.getString('activeDeck') ?? 'Starterdeck';

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
    await prefs.setString('activeDeck', _activeDeck);
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
      removeSavedHobby(
        hobby,
      ); // Wenn es erledigt ist, fliegt es aus den Gemerkten raus
      _saveToPrefs();
      notifyListeners();
    }
  }

  // Die Funktion für deinen neuen roten Reset-Button!
  Future<void> resetProgress() async {
    _savedHobbies.clear();
    _completedHobbies.clear();
    _activeDeck = 'Starterdeck';
    await _saveToPrefs();
    notifyListeners();
  }
}
