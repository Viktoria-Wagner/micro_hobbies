import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../Theme/app_theme.dart';
import '../Theme/theme_provider.dart';
import '../Settings/reset_dialog.dart';
import '../SharedWidgets/custom_ui_elements.dart'; // NEU: Unsere ausgelagerten UI-Elemente!

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: AppColors.backgroundPastel,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Konto und Cloud
          const SectionHeader('Konto & Backup'),
          PastelCard(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.apple, color: AppColors.textDark),
                  title: Text('Mit Apple anmelden', style: AppTypography.body),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.dividerLight),
                  onTap: () {},
                ),
                AppStyles.listDivider,
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/svg/google-svgrepo-com.svg',
                    width: 24,
                    height: 24,
                  ),
                  title: Text('Mit Google anmelden', style: AppTypography.body),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.dividerLight),
                  onTap: () {},
                ),
                AppStyles.listDivider,
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: AppColors.primaryAccent),
                  title: Text('Mit E-Mail anmelden', style: AppTypography.body),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.dividerLight),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Darstellung
          const SectionHeader('Darstellung'),
          PastelCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.primaryAccent; // Dein weicheres Orange
                    }
                    return Colors.grey.shade400; // Farbe, wenn der Schalter aus ist
                  }),
                  trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.primaryAccent.withAlpha(77); // Sanfte Spur im Hintergrund
                    }
                    return AppColors.dividerLight; // Spur, wenn der Schalter aus ist
                  }),
                  secondary: Icon(Icons.dark_mode_outlined, color: Colors.deepPurple[300]), // Weicheres Lila
                  title: Text('Dark Mode', style: AppTypography.body),
                  value: ThemeProvider.isDark,
                  onChanged: (bool value) {
                    //Befehl an den Provider senden, um den Dark Mode zu ändern
                    themeProvider.toggleDarkMode(value);
                  },
                ),
                AppStyles.listDivider,
                ListTile(
                  leading: Icon(Icons.language, color: Colors.blue[300]),
                  title: Text('Sprache', style: AppTypography.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFlagButton('🇩🇪', 'Deutsch', themeProvider),
                      const SizedBox(width: 10),
                      _buildFlagButton('🇬🇧', 'English', themeProvider),
                    ],
                  ),
                ),
                AppStyles.listDivider,
                ListTile(
                  leading: Icon(Icons.format_size, color: Colors.green[300]),
                  title: Text('Schriftgröße', style: AppTypography.body),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 16, bottom: 16),
                  child: SegmentedButton<String>(
                    segments: [
                      ButtonSegment(value: 'Klein', label: Text('Klein', style: AppTypography.body)),
                      ButtonSegment(value: 'Mittel', label: Text('Mittel', style: AppTypography.body)),
                      ButtonSegment(value: 'Groß', label: Text('Groß', style: AppTypography.body)),
                    ],
                    selected: {themeProvider.currentFontSize},
                    onSelectionChanged: (Set<String> newSelection) {
                      themeProvider.setFontSize(newSelection.first);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.primaryAccent.withAlpha(51);
                          }
                          return Colors.transparent;
                        },
                      ),
                      side: WidgetStateProperty.all(BorderSide(color: AppColors.primaryAccent.withAlpha(77))),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daten - Zurücksetzen
          const SizedBox(height: 24),
          const SectionHeader('Daten'),
          PastelCard(
            child: ListTile(
              leading: Icon(Icons.delete_forever, color: Colors.red[400]),
              title: Text('Fortschritt zurücksetzen', style: AppTypography.body.copyWith(color: Colors.red[400])),
              onTap: () {
                ResetDialogs.showResetDialog(context);
              },
            ),
          ),
          const SizedBox(height: 40),

          // Über den Entwickler
          const SizedBox(height: 10),
          Text(
            'Made with ❤️ by Viktoria Wagner',
            textAlign: TextAlign.center,
            style: AppTypography.bodyBold.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 5),
          Text(
            'Micro Hobbies v1.0.0',
            textAlign: TextAlign.center,
            style: AppTypography.subtitle,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }


  Widget _buildFlagButton(String emoji, String language, ThemeProvider provider) {
    bool isSelected = provider.currentLanguage == language;

    return GestureDetector(
      onTap: () {
        provider.setLanguage(language);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryAccent.withAlpha(51) : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryAccent : AppColors.dividerLight,
            width: 2,
          ),
          borderRadius: AppStyles.radiusSmall,
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}