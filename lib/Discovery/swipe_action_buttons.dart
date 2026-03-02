import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:new_micro_hobbies/Theme/app_theme.dart';

class SwipeActionButtons extends StatelessWidget {
  final CardSwiperController controller;

  const SwipeActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //Etwas mehr vertikaler Abstand für eine luftigere Optik
      padding: const EdgeInsets.only(bottom: 40.0, top: 20.0),
      child: Row(
        //Verteilt die Buttons gleichmäßig mit Platz dazwischen
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Ablehnen-Button
          FloatingActionButton(
            onPressed: () => controller.swipe(CardSwiperDirection.left),
            backgroundColor: AppColors.actionRed,
            elevation: 4,
            //Ein subtiler Schatten
            shape: const CircleBorder(),
            child: const Icon(Icons.close, color: Colors.white, size: 35),
          ),

          //Undo-Button
          FloatingActionButton(
            onPressed: () => controller.undo(),
            backgroundColor: AppColors.actionGrey,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.refresh, color: Colors.white, size: 35),
          ),

          // Akzeptieren-Button
          FloatingActionButton(
            onPressed: () => controller.swipe(CardSwiperDirection.right),
            backgroundColor: AppColors.actionGreen,
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(Icons.check, color: Colors.white, size: 35),
          ),
        ],
      ),
    );
  }
}
