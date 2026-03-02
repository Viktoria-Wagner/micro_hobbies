import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/hobby_data.dart';
import 'discover_menu_button.dart';
import 'swipe_deck.dart';
import 'swipe_action_buttons.dart';
import '../theme/app_theme.dart';
import 'deck_drawer.dart';

class DiscoverScreen extends StatelessWidget {
  final CardSwiperController controller;
  final List<Hobby> hobbies;
  // Die Wisch-Auswertung
  final bool Function(int, int?, CardSwiperDirection) onSwipe;

  const DiscoverScreen({
    super.key,
    required this.controller,
    required this.hobbies,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    //Scaffold, damit der Drawer (Seitenleiste) funktioniert
    return Scaffold(
      backgroundColor: Colors.transparent, // Damit der Hintergrund vom HomeScreen durchscheint
      drawer: const DeckDrawer(), //Die Seitenleiste
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                //Unten liegt die "Leer"-Meldung, oben drauf das Deck.
                child: Stack(
                  children: [
                    // 1. Die Meldung, wenn das Deck leer ist (liegt ganz unten)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.style, size: 80, color: AppColors.textLight),
                          const SizedBox(height: 16),
                          Text(
                              'Deck durchgespielt!',
                              style: AppTypography.headlineMedium  ),
                          const SizedBox(height: 8),
                          Text(
                              'Wähle oben links ein neues Deck aus.',
                              style: AppTypography.subtitle
                          ),
                        ],
                      ),
                    ),

                    // 2. Das Wisch-Deck (verdeckt die Meldung, solange Karten da sind)
                    if (hobbies.isNotEmpty)
                      Container(
                        alignment: Alignment.center,
                        child: HobbySwipeDeck(
                          controller: controller,
                          hobbies: hobbies,
                          onSwipe: onSwipe,
                        ),
                      ),
                  ],
                ),
              ),

              SwipeActionButtons(
                controller: controller,
              ),
            ],
          ),

          //Der quadratische Menü-Button oben links (als Overlay)
          const DiscoverMenuButton(),
        ],
      ),
    );
  }
}