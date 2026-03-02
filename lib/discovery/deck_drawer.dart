import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/hobby_provider.dart';

class DeckDrawer extends StatelessWidget {
  const DeckDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HobbyProvider>();

    return Drawer(
      backgroundColor: AppColors.backgroundPastel,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Kartendecks',
                style: AppTypography.headlineLarge,
              ),
            ),

            // --- VERFÜGBARE DECKS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('FREIGESCHALTET', style: AppTypography.sectionHeader),
            ),
            _buildDeckTile(context, provider, 'Starterdeck', Icons.star_rounded, isLocked: false),
            _buildDeckTile(context, provider, 'Entspannt (Leicht)', Icons.battery_charging_full_rounded, isLocked: false),
            _buildDeckTile(context, provider, 'Fokus (Mittel)', Icons.battery_std_rounded, isLocked: false),
            _buildDeckTile(context, provider, 'Meister (Schwer)', Icons.battery_alert_rounded, isLocked: false),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: AppColors.dividerLight, indent: 16, endIndent: 16),
            ),

            // --- GESPERRTE DECKS (Werbung) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('PREMIUM DECKS', style: AppTypography.sectionHeader),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDeckTile(context, provider, 'Sport & Fitness', Icons.directions_run, isLocked: true),
                  _buildDeckTile(context, provider, 'Natur & Outdoor', Icons.park, isLocked: true),
                  _buildDeckTile(context, provider, 'Ernährung', Icons.restaurant, isLocked: true),
                  _buildDeckTile(context, provider, 'Kreativität', Icons.palette, isLocked: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckTile(BuildContext context, HobbyProvider provider, String title, IconData icon, {required bool isLocked}) {
    bool isActive = provider.activeDeck == title;

    return ListTile(
      leading: Icon(
          icon,
          color: isLocked ? AppColors.textLight : (isActive ? AppColors.primaryAccent : AppColors.textDark)
      ),
      title: Text(
        title,
        style: AppTypography.bodyBold.copyWith(
          color: isLocked ? AppColors.textLight : AppColors.textDark,
        ),
      ),
      trailing: isLocked
          ? const Icon(Icons.lock, color: AppColors.actionRed, size: 20)
          : (isActive ? const Icon(Icons.check_circle, color: AppColors.actionGreen) : null),
      onTap: () {
        if (isLocked) {
          // Hier kommt später die Werbe-Logik rein!
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Schau dir eine kurze Werbung an, um dieses Deck freizuschalten!', style: AppTypography.bodyBold.copyWith(color: Colors.white)),
              backgroundColor: AppColors.primaryAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
            ),
          );
        } else {
          // Deck wechseln und Drawer schließen
          provider.setActiveDeck(title);
          Navigator.pop(context);
        }
      },
    );
  }
}