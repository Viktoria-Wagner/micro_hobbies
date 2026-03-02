import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/hobby_provider.dart';

class AdPopupDialog extends StatefulWidget {
  final String deckName;

  const AdPopupDialog({super.key, required this.deckName});

  @override
  State<AdPopupDialog> createState() => _AdPopupDialogState();
}

class _AdPopupDialogState extends State<AdPopupDialog> {
  bool _isWatchingAd = false;

  void _simulateAdWatching(BuildContext context) async {
    setState(() {
      _isWatchingAd = true;
    });

    // Wir simulieren eine 2-sekündige Werbepause
    await Future.delayed(const Duration(seconds: 2));

    if (context.mounted) {
      // 1. Deck im Provider freischalten (und aktivieren)
      context.read<HobbyProvider>().unlockPremiumDeck(widget.deckName);

      // 2. Dialog schließen
      Navigator.of(context).pop();

      // 3. Erfolgsmeldung anzeigen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 ${widget.deckName} wurde freigeschaltet!', style: AppTypography.bodyBold.copyWith(color: Colors.white)),
          backgroundColor: AppColors.actionGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardWhite,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusLarge),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _isWatchingAd
            ? _buildWatchingAdState()
            : _buildInitialState(context),
      ),
    );
  }

  // Zustand 1: Die Frage, ob Werbung geschaut werden soll
  Widget _buildInitialState(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.ondemand_video_rounded, color: AppColors.primaryAccent, size: 60),
        const SizedBox(height: 16),
        Text(
          'Premium Deck',
          style: AppTypography.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Schau dir einen kurzen Werbeclip an, um das Deck "${widget.deckName}" dauerhaft freizuschalten.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryAccent,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: AppStyles.radiusSmall),
          ),
          onPressed: () => _simulateAdWatching(context),
          child: Text('Werbung ansehen', style: AppTypography.textWhiteBold),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Später', style: AppTypography.bodyBold.copyWith(color: AppColors.textMuted)),
        ),
      ],
    );
  }

  // Zustand 2: Die "Werbung läuft" Simulation
  Widget _buildWatchingAdState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        const CircularProgressIndicator(color: AppColors.primaryAccent),
        const SizedBox(height: 24),
        Text(
          'Werbung wird abgespielt...',
          style: AppTypography.bodyBold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Bitte warte einen Moment.',
          style: AppTypography.subtitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}