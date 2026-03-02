import 'package:flutter/material.dart';
import '../Theme/app_theme.dart';

//Überschrift in bspw. den Einstellungen
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: AppTypography.sectionHeader,
      ),
    );
  }
}

//Kasten für unterschiedliche Elemente wie bspw. bei den Einstellungen
class PastelCard extends StatelessWidget {
  final Widget child;

  const PastelCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: AppStyles.radiusLarge,
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: child,
    );
  }
}