import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/hobby_data.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  final _formKey = GlobalKey<FormState>(); // Der Schlüssel zum Formular-Status

  // Da Category ein String ist, definieren wir hier unsere Auswahlmöglichkeiten:
  final List<String> _categories = [
    'Kreativität',
    'Sport & Akrobatik',
    'Kochen & Backen',
    'Outdoor',
    'Mentale Gesundheit',
    'Kunst',
    'Musik',
    'Technik',
    'DIY',
    'Natur & Wissen',
    'Geschicklichkeit',
    'Sonstiges',
  ];

  // Controller speichern den Text, den der Nutzer tippt
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // Standardwerte für die Dropdowns
  String _selectedCategory = 'Sonstiges';
  Difficulty _selectedDifficulty = Difficulty.leicht;

  bool _isSending = false; // Für den Ladekreis

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Wenn alles ausgefüllt ist:
      setState(() => _isSending = true);

      // SIMULATION: Wir tun so, als würden wir es an einen Server senden (2 Sek warten)
      // Später kommt hier der Firebase-Code hin
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isSending = false);

        final screenHeight = MediaQuery.of(context).size.height;

        // Erfolgsmeldung
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Danke! Deine Idee wurde gesendet. 🚀',
              style: AppTypography.bodyBold.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.actionGreen,
            behavior: SnackBarBehavior.floating,
            //Margin schiebt die SnackBar an den oberen Rand
            margin: EdgeInsets.only(
                bottom: screenHeight - 170,
                left: 20,
                right: 20
            ),
            shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
          ),
        );
        Navigator.pop(context); // Screen schließen
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPastel,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Idee einsenden', style: AppTypography.headlineMedium),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Hilf uns, Micro Hobbies besser zu machen! Welches Hobby fehlt noch?',
                style: AppTypography.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              //Titel
              _buildLabel('Titel des Hobbys'),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('z.B. Urban Gardening'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Bitte Titel eingeben'
                    : null,
              ),
              const SizedBox(height: 24),

              //Kategorie und Schwierigkeit als Dropdown
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Kategorie'),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: _selectedCategory,
                          decoration: _inputDecoration(''),
                          items: _categories.map((String cat) {
                            return DropdownMenuItem(
                              value: cat,
                              // Text wird bei Bedarf mit "..." abgekürzt
                              child: Text(
                                cat,
                                style: AppTypography.body,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _selectedCategory = val!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Schwierigkeit'),
                        DropdownButtonFormField<Difficulty>(
                          isExpanded: true,
                          initialValue: _selectedDifficulty,
                          decoration: _inputDecoration(''),
                          items: Difficulty.values.map((diff) {
                            return DropdownMenuItem(
                              value: diff,
                              child: Row(
                                children: [
                                  // Kleiner farbiger Punkt passend zur Schwierigkeit
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: diff.baseColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  //Text flexibel machen, da Overflow auf dem Bildschirm
                                  Flexible(
                                    child: Text(
                                      diff.label,
                                      style: AppTypography.body,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _selectedDifficulty = val!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              //Beschreibung
              _buildLabel('Kurzbeschreibung'),
              TextFormField(
                controller: _descController,
                maxLines: 4, // Größeres Feld
                decoration: _inputDecoration(
                  'Was macht dieses Hobby besonders?',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Bitte Beschreibung eingeben'
                    : null,
              ),
              const SizedBox(height: 40),

              //Senden Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppStyles.radiusSmall,
                  ),
                ),
                onPressed: _isSending ? null : _submitForm,
                // Deaktiviert beim Senden
                child: _isSending
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Vorschlag senden',
                        style: AppTypography.textWhiteBold,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kleine Hilfsmethoden für saubereren Code
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(text, style: AppTypography.bodyBold),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.body.copyWith(color: AppColors.textLight),
      filled: true,
      fillColor: AppColors.cardWhite,
      border: OutlineInputBorder(
        borderRadius: AppStyles.radiusSmall,
        borderSide: BorderSide.none, // Keine Linie, nur Schatten/Farbe
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
