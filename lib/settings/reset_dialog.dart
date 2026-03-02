import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/hobby_provider.dart';
import '../theme/app_theme.dart';

class ResetDialogs {
  // Hilfsmethode: Der Bestätigungs-Dialog für das Zurücksetzen
  static void showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundPastel, // Passt sich an den Dark Mode an
          shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusLarge),
          title: Text(
            'Fortschritt löschen?',
            style: AppTypography.headlineMedium,
          ),
          content: Text(
            'Bist du sicher? Alle deine gemerkten und erledigten Hobbys werden dauerhaft gelöscht.\n\nDies kann nicht rückgängig gemacht werden!',
            style: AppTypography.body,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            //Lösch-Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.actionRed,
                shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // 1. Fenster schließen
                _performReset(context);            // 2. Daten löschen
              },
              child: Text('Ja, löschen', style: AppTypography.textWhiteBold),
            ),
            // Abbrechen-Button
            TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.actionGreen,
                shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Schließt nur das Fenster
              },
              child: Text('Abbrechen', style: AppTypography.textWhiteBold),
            ),
          ],
        );
      },
    );
  }

  // Die eigentliche Lösch-Logik
  static Future<void> _performReset(BuildContext context) async {
    await context.read<HobbyProvider>().resetProgress();

    // Kleines visuelles Feedback für den Nutzer, dass es geklappt hat
    if (context.mounted) {
      showDialog(
        context: context,
        barrierDismissible: false, // Verhindert, dass der Nutzer es wegklickt, bevor die Zeit um ist
        builder: (BuildContext dialogContext) {
          // Schließt den Dialog automatisch nach 2 Sekunden
          Future.delayed(const Duration(seconds: 2), () {
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
            }
          });

          return Dialog(
            backgroundColor: AppColors.cardWhite,
            shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusLarge),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline, color: AppColors.actionGreen, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    'Alles auf null!',
                    style: AppTypography.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dein Fortschritt wurde gelöscht.',
                    style: AppTypography.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}