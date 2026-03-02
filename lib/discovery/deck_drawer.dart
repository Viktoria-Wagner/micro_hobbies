import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'deck_list_tile.dart';

class DeckDrawer extends StatelessWidget {
  const DeckDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Text('STANDARD', style: AppTypography.sectionHeader),
            ),
            const DeckListTile(title: 'Starterdeck', icon: Icons.star_rounded, isPremium: false),
            const DeckListTile(title: 'Entspannt (Leicht)', icon: Icons.spa_rounded, isPremium: false),
            const DeckListTile(title: 'Fokus (Mittel)', icon: Icons.center_focus_strong_rounded, isPremium: false),
            const DeckListTile(title: 'Meister (Schwer)', icon: Icons.local_fire_department_rounded, isPremium: false),
             Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: AppColors.dividerLight, indent: 16, endIndent: 16),
            ),

            // --- PREMIUM DECKS (Werbung) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('PREMIUM', style: AppTypography.sectionHeader),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  DeckListTile(title: 'Sport & Fitness', icon: Icons.directions_run, isPremium: true),
                  DeckListTile(title: 'Natur & Outdoor', icon: Icons.park, isPremium: true),
                  DeckListTile(title: 'Ernährung', icon: Icons.restaurant, isPremium: true),
                  DeckListTile(title: 'Kreativität', icon: Icons.palette, isPremium: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}