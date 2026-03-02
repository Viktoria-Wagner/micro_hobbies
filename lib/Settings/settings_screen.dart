import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'Deutsch';
  String _selectedFontSize = 'Mittel';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEAD1),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //Konto und Cloud
          _buildSectionHeader('Konto & Backup'),
          _buildPastelCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.apple, color: Colors.black87),
                  title: const Text('Mit Apple anmelden'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 50, color: Colors.black12),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/google-svgrepo-com.svg',
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('Mit Google anmelden'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 50, color: Colors.black12),
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: Colors.orangeAccent),
                  title: const Text('Mit E-Mail anmelden'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          //Darstellung
          _buildSectionHeader('Darstellung'),
          _buildPastelCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Dark Mode
                SwitchListTile(
                  activeColor: Colors.orangeAccent, // Weicheres Orange
                  secondary: Icon(Icons.dark_mode_outlined, color: Colors.deepPurple[300]), // Weicheres Lila
                  title: const Text('Dark Mode'),
                  value: _isDarkMode,
                  onChanged: (bool value) {
                    setState(() => _isDarkMode = value);
                  },
                ),
                const Divider(height: 1, indent: 50, color: Colors.black12),
                //Sprache
                ListTile(
                  leading: Icon(Icons.language, color: Colors.blue[300]),
                  title: const Text('Sprache'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFlagButton('🇩🇪', 'Deutsch'),
                      const SizedBox(width: 10),
                      _buildFlagButton('🇬🇧', 'English'),
                    ],
                  ),
                ),
                const Divider(height: 1, indent: 50, color: Colors.black12),
                //Schriftgröße
                ListTile(
                  leading: Icon(Icons.format_size, color: Colors.green[300]),
                  title: const Text('Schriftgröße'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 16, bottom: 16),
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'Klein', label: Text('Klein')),
                      ButtonSegment(value: 'Mittel', label: Text('Mittel')),
                      ButtonSegment(value: 'Groß', label: Text('Groß')),
                    ],
                    selected: {_selectedFontSize},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() {
                        _selectedFontSize = newSelection.first;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.orangeAccent.withOpacity(0.2); // Noch sanfteres Pastell-Orange
                          }
                          return Colors.transparent;
                        },
                      ),
                      // Macht die Ränder des SegmentedButtons weicher
                      side: WidgetStateProperty.all(BorderSide(color: Colors.orangeAccent.withOpacity(0.3))),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          //Daten - Zurücksetzten
          _buildSectionHeader('Daten'),
          _buildPastelCard(
            child: ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red[300]),
              title: Text('Fortschritt zurücksetzen', style: TextStyle(color: Colors.red[400])),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 40),
          //Über den Entwickler
          const SizedBox(height: 10),
          const Text(
            'Made with ❤️ by Viktoria Wagner',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 5),
          const Text(
            'Micro Hobbies v1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black38),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  //Hilfsmethode: Überschriften
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black45, // Weicheres Grau
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  //Hilfsmethode: Pastell-Karte
  Widget _buildPastelCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: child,
    );
  }

  // Hilfsmethode: Flaggen
  Widget _buildFlagButton(String emoji, String language) {
    bool isSelected = _selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orangeAccent.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.orangeAccent : Colors.black12,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12), // Etwas runder für den Pastell-Look
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}