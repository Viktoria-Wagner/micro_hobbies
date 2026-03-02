import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_theme.dart';
import '../models/hobby_data.dart';
import '../shared_widgets/info_badge.dart';

class HobbySwipeDeck extends StatelessWidget {
  final CardSwiperController controller;
  final List<Hobby> hobbies;
  final bool Function(int, int?, CardSwiperDirection) onSwipe;

  const HobbySwipeDeck({
    super.key,
    required this.controller,
    required this.hobbies,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      controller: controller,
      cardsCount: hobbies.length,
      isLoop: false,
      onSwipe: onSwipe,
      padding: const EdgeInsets.all(24.0),
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
        final hobby = hobbies[index];

        return FlipCard(
          direction: FlipDirection.HORIZONTAL,
          speed: 400,
          fill: Fill.fillBack,

          // Vorderseite
          front: _buildFrontCard(hobby),
          // Rückseite
          back: _buildBackCard(hobby),
        );
      },
    );
  }

  // --- DESIGN: VORDERSEITE ---
  Widget _buildFrontCard(Hobby hobby) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: AppStyles.radiusLarge,
          boxShadow: AppStyles.cardShadow,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(hobby.svgPath, width: 120),
            const SizedBox(height: 20),
            Text(
              hobby.title,
              textAlign: TextAlign.center,
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: 16),

            // NEU: Kleine schicke "Badges" für Kategorie und Zeit
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                InfoBadge(
                    icon: Icons.category,
                    text: hobby.category,
                    bgColor: Colors.orangeAccent.withAlpha(51), // 51 entspricht 20% Deckkraft
                    textColor: Colors.orange[800]!
                ),
                InfoBadge(
                    icon: Icons.schedule,
                    text: hobby.time,
                    bgColor: Colors.blueAccent.withAlpha(51),
                    textColor: Colors.blue[800]!
                ),
                InfoBadge(
                  icon: Icons.bolt,
                  text: hobby.difficulty.label,
                  bgColor: hobby.difficulty.baseColor.withAlpha(51),
                  textColor: hobby.difficulty.baseColor[800]!,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  hobby.description,
                  textAlign: TextAlign.center,
                  style: AppTypography.body,
                ),
              ),
            ),
          Text('Tippe für Details 👆', style: AppTypography.actionHint)
          ],
        ),
      ),
    );
  }

  // --- DESIGN: RÜCKSEITE ---
  Widget _buildBackCard(Hobby hobby) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundPastel,
          borderRadius: AppStyles.radiusLarge,
          boxShadow: AppStyles.cardShadow,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Text linksbündig auf der Rückseite
          children: [
            // Titel und SVG oben verkleinert
            Row(
              children: [
                SvgPicture.asset(hobby.svgPath, width: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    hobby.title,
                    style: AppTypography.headlineMedium,
                  ),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 1),

            // Scrollbarer Bereich für Details und Materialien
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('So geht\'s:', style: AppTypography.highlightText),                    const SizedBox(height: 8),
                    Text(
                      hobby.details,
                      style: AppTypography.body,
                    ),
                    const SizedBox(height: 20),
                    Text('Das brauchst du:', style: AppTypography.highlightText),
                    const SizedBox(height: 8),
                    Text(
                      '• ${hobby.materials}', // Als kleiner Spiegelstrich
                      style: AppTypography.body,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            Center(
              child: Text('Tippe zum Umdrehen 🔄', style: AppTypography.actionHint),
            )
          ],
        ),
      ),
    );
  }
}