import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/hobby_provider.dart';
import '../shared_widgets/ad_popup_dialog.dart';

class DeckListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPremium;

  const DeckListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isPremium,
  });

  @override
  Widget build(BuildContext context) {
    // Das Tile holt sich selbst den Provider!
    final provider = context.watch<HobbyProvider>();

    bool isActive = provider.activeDeck == title;
    bool isLocked = isPremium && !provider.isPremiumDeckUnlocked(title);

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
          // Ruft unser schickes Werbe-Popup auf
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AdPopupDialog(deckName: title),
          );
        } else {
          provider.setActiveDeck(title);
          Navigator.pop(context); // Drawer schließen
        }
      },
    );
  }
}