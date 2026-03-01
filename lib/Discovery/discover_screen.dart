import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/hobby_data.dart';
import 'swipe_deck.dart';
import 'swipe_action_buttons.dart';

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
    return Column(
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
                    Icon(Icons.style, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                        'Deck durchgespielt!',
                        style: TextStyle(fontSize: 22, color: Colors.grey[600], fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Wähle oben links ein neues Deck aus.',
                        style: TextStyle(color: Colors.grey[500])
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
    );
  }
}