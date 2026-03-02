import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DiscoverMenuButton extends StatelessWidget {
  const DiscoverMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      // Der Builder ist wichtig, damit Scaffold.of(context) den Drawer findet
      child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Öffnet die Seitenleiste
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardWhite.withAlpha(180), //etwas transparenter, damit nichts überdeckt wird
                  borderRadius: AppStyles.radiusSmall,
                  boxShadow: AppStyles.cardShadow,
                ),
                child: Icon(Icons.menu_open_rounded, color: AppColors.textDark, size: 28),
              ),
            );
          }
      ),
    );
  }
}