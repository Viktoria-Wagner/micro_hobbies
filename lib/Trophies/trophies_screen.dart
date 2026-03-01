import 'package:flutter/material.dart';
import '../models/hobby_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrophiesScreen extends StatelessWidget {
  final List<Hobby> completedHobbies;

  const TrophiesScreen({
    super.key,
    required this.completedHobbies,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Hintergrundbild aus assets
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              //Bild laden
              image: AssetImage('assets/images/shelf.png'),
              // BoxFit.cover sorgt dafür, dass das Regal den ganzen Platz ausfüllt,
              // auch wenn etwas abgeschnitten wird.
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Wenn leer, zeigen wir den Text. Wenn voll, das Grid.
        completedHobbies.isEmpty
            ? _buildEmptyStateForShelf()
            : _buildTrophyGrid(),
      ],
    );
  }

  // Hilfsmethode für den leeren Zustand (Text auf dem Regal)
  Widget _buildEmptyStateForShelf() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        // Ein Container mit leicht transparentem Hintergrund macht den Text
        // auf dem Holz besser lesbar.
        child: Card(
          color: Color(0xAAFFEAD1), // Dein Beige, aber leicht durchsichtig
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Dein Trophäenschrank ist noch leer. 🪹\n\nErledige Hobbys, um hier Badges zu sammeln!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  // Hilfsmethode für das Grid mit den Emojis
  Widget _buildTrophyGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // Diese Werte bestimmen, wo die Emojis landen.
        // Wenn die Emojis schweben, mach die Ratio kleiner (z.B. 0.7).
        // Wenn sie im Boden versinken, mach sie größer (z.B. 0.9).
        childAspectRatio: 0.92,
        crossAxisSpacing: 15,
        mainAxisSpacing: 0, // Abstand zum nächsten Regalbrett
      ),
      itemCount: completedHobbies.length,
      itemBuilder: (context, index) {
        final hobby = completedHobbies[index];

        return Container(
          // Alignment.bottomCenter drückt das Emoji auf den "Boden" der Zelle
          alignment: Alignment.bottomCenter,
          child: Tooltip(
            message: hobby.title,
            preferBelow: false,
            textStyle: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
            decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              hobby.svgPath,
              width: 55,  // Hier kannst du die Größe deines SVGs auf dem Brett anpassen
              height: 55,
            ),
          ),
        );
      },
    );
  }
}