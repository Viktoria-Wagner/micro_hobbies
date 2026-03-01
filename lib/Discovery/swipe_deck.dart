import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import '../models/hobby_data.dart';
import '../SharedWidgets/info_badge.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
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
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                    bgColor: Colors.orangeAccent.withOpacity(0.2),
                    textColor: Colors.orange[800]!
                ),
                InfoBadge(
                    icon: Icons.schedule,
                    text: hobby.time,
                    bgColor: Colors.blueAccent.withOpacity(0.2),
                    textColor: Colors.blue[800]!
                ),
                InfoBadge(
                    icon: Icons.bolt,
                    text: hobby.difficulty,
                    bgColor: Colors.purpleAccent.withOpacity(0.2),
                    textColor: Colors.purple[800]!
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  hobby.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey[800], height: 1.4),
                ),
              ),
            ),
            const Text('Tippe für Details 👆', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold))
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
          color: const Color(0xFFFFF9F0), // Leichtes Beige für die Rückseite
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
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
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    const Text('So geht\'s:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
                    const SizedBox(height: 8),
                    Text(
                      hobby.details,
                      style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.4),
                    ),
                    const SizedBox(height: 20),
                    const Text('Das brauchst du:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
                    const SizedBox(height: 8),
                    Text(
                      '• ${hobby.materials}', // Als kleiner Spiegelstrich
                      style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.4),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Center(
              child: Text('Tippe zum Umdrehen 🔄', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}