import 'package:flutter/material.dart';
import 'theme_provider.dart';

class AppColors {
  //Hintergründe
  //Reagieren auf den Dark Mode!
  static Color get backgroundPastel => ThemeProvider.isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFEAD1);
  static Color get cardWhite => ThemeProvider.isDark ? const Color(0xFF2C2C2C) : Colors.white;
  static Color get navBarBackground => ThemeProvider.isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFF6EB);
  static Color get backgroundPastelTransparent => ThemeProvider.isDark ? const Color(0xAA1E1E1E) : const Color(0xAAFFEAD1); // Für das leere Regal

  // Wisch- & Aktions-Farben
  static const Color actionRed = Color(0xFFF4A896); // Ablehnen & Löschen
  static const Color actionGreen = Color(0xFF81C784); // Akzeptieren
  static const Color actionYellow = Color(0xFFF8D364); // Erledigt (Trophäen)
  static const Color actionGrey = Color(0xFFB0BEC5); // Undo-Button

  //Akzente & Icons
  static const Color primaryAccent = Colors.orangeAccent;
  static const Color avatarPurple = Color(0x8CE5A8F3); // Hintergrund der runden Icons

  //Texte & Linien
  //Reagieren auf den Dark Mode
  static Color get textDark => ThemeProvider.isDark ? Colors.white : Colors.black87; // Normaler Text
  static Color get textMuted => ThemeProvider.isDark ? Colors.white70 : Colors.black54; // Grauer Text
  static Color get textLight => ThemeProvider.isDark ? Colors.white38 : Colors.black38; // Sehr heller Text
  static Color get dividerLight => ThemeProvider.isDark ? Colors.white12 : Colors.black12; // Zarte Ränder und Trennlinien

}

class AppStyles {
  //Standard-Schatten für Karten
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
        color: AppColors.dividerLight,
        blurRadius: 10,
        spreadRadius: 2
    )
  ];

  //Abgerundete Ecken
  static BorderRadius get radiusLarge => BorderRadius.circular(20); // Für Swipe-Karten & Dialoge
  static BorderRadius get radiusSmall => BorderRadius.circular(12); // Für Listen & Buttons

// Standard-Trennlinie für Listen (wie in den Settings)
  static Widget get listDivider => Divider(height: 1, indent: 50, color: AppColors.dividerLight);}

class AppTypography {
  // Später wird dieser Wert durch die Einstellungen (Klein/Mittel/Groß) verändert.
  // Z.B. Klein = 0.8, Mittel = 1.0, Groß = 1.2
  //holen uns den Skalierungsfaktor live aus dem ThemeProvider!
  static double get fontScale => ThemeProvider.scale;

  //Überschriften
  static TextStyle get headlineLarge => TextStyle(
    fontSize: 26 * fontScale,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: 22 * fontScale,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  //Standart-Texte
  static TextStyle get body => TextStyle(
    fontSize: 16 * fontScale,
    color: AppColors.textDark,
    height: 1.4, // Macht den Text besser lesbar
  );

  static TextStyle get bodyBold => TextStyle(
    fontSize: 16 * fontScale,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  //Spezialtexte

  // Für farbige Zwischenüberschriften wie "So geht's:"
  static TextStyle get highlightText => bodyBold.copyWith(color: AppColors.primaryAccent);

  // Für die kursive Einleitung der Hobbys
  static TextStyle get descriptionItalic => body.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.w600);

  // Für Handlungsaufforderungen wie "Tippe für Details"
  static TextStyle get actionHint => subtitle.copyWith(fontWeight: FontWeight.bold);

  // Weißer, fetter Text (z.B. für Tooltips oder Buttons)
  static TextStyle get textWhiteBold => bodyBold.copyWith(color: Colors.white);

  //Untertitel & kleiner Text
  static TextStyle get subtitle => TextStyle(
    fontSize: 14 * fontScale,
    color: AppColors.textMuted,
  );

  static TextStyle get sectionHeader => TextStyle(
    fontSize: 12 * fontScale,
    fontWeight: FontWeight.bold,
    color: AppColors.textMuted,
    letterSpacing: 1.2,
  );
}