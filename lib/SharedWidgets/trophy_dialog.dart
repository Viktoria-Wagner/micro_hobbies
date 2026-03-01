import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/hobby_data.dart'; // Pfad ggf. anpassen!

class TrophyDialog extends StatelessWidget {
  final Hobby hobby;

  const TrophyDialog({
    super.key,
    required this.hobby,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFFFFEAD1),
      title: const Text(
        'Trophäe freigeschaltet!',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            hobby.svgPath,
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 20),
          Text(
            'Du hast "${hobby.title}" gemeistert.\nSuper gemacht!',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orangeAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Schließt das Pop-up
          },
          child: const Text('Juhu!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}