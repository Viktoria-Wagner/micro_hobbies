import 'package:flutter/material.dart';
import '../Theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      //Design:_________________________________________________________________
      //Hintergrundfarbe der Leiste
      backgroundColor: AppColors.navBarBackground,

      //Die Farbe des aktuell ausgewählten Tabs
      selectedItemColor: AppColors.textDark,

      //Die Farbe der nicht ausgewählten Tabs
      unselectedItemColor: AppColors.textMuted,

      //Ein weicher Schatten, der die Leiste leicht vom Hintergrund abhebt
      elevation: 15,

      //Typ festlegen (Verhindert, dass die Icons komisch herumspringen, wenn man klickt)
      type: BottomNavigationBarType.fixed,
     //_________________________________________________________________________
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.swipe),
          label: 'Entdecken',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Meine Hobbys',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events),
          label: 'Trophäen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Einstellungen',
        ),
      ],
    );
  }
}