import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/hobby_data.dart';
import '../SharedWidgets/info_badge.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Hobby> savedHobbies;
  final Function(Hobby) onDelete;
  final Function(Hobby) onComplete;

  const FavoritesScreen({
    super.key,
    required this.savedHobbies,
    required this.onDelete,
    required this.onComplete,
  });

  //Info-Fenster zeigt details zu den favorisierten Hobbies
  void _zeigeDetails(BuildContext context, Hobby hobby) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //Erlaubt dem Fenster, höher als 50% des Bildschirms zu werden!
      backgroundColor: const Color(0xFFFFEAD1), // Generelle Hintergrundfarbe
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          // Padding unten sorgt dafür, dass die Navigation/Home-Leiste des Handys nichts verdeckt
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: MediaQuery.of(context).padding.bottom + 24.0,
          ),
          child: SingleChildScrollView( // Macht den Inhalt scrollbar, falls der Text sehr lang ist
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Richtet Texte linksbündig aus, liest sich besser!
              children: [

                //Der Titel
                Center(
                  child: Text(
                    hobby.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //Die Info-Badges (Kategorie & Zeit)
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      InfoBadge(
                          icon: Icons.category,
                          text: hobby.category,
                          bgColor: Colors.orangeAccent.withOpacity(0.3),
                          textColor: Colors.orange[900]!
                      ),
                      InfoBadge(
                          icon: Icons.schedule,
                          text: hobby.time,
                          bgColor: Colors.blueAccent.withOpacity(0.3),
                          textColor: Colors.blue[900]!
                      ),
                      InfoBadge(
                        icon: Icons.bolt,
                        text: hobby.difficulty.label, // Holt das Wort "Leicht", "Mittel", "Schwer"
                        bgColor: hobby.difficulty.baseColor.withOpacity(0.2), // Heller Hintergrund
                        textColor: hobby.difficulty.baseColor[800]!, // Dunkler Text
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.black12, thickness: 2),
                const SizedBox(height: 16),

                //Die Kurzbeschreibung als Einleitung
                Text(
                  hobby.description,
                  style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),

                //Materialien
                const Text(
                  'Das brauchst du:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                const SizedBox(height: 8),
                Text(
                  '• ${hobby.materials}',
                  style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[850]),
                ),
                const SizedBox(height: 24),

                //Die detaillierte Anleitung
                const Text(
                  'So geht\'s:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                ),
                const SizedBox(height: 8),
                Text(
                  hobby.details,
                  style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey[850]),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wenn die Liste noch leer ist, wird ein netten Hinweis gezeigt
    if (savedHobbies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ein großes, sanftes Icon für den leeren Zustand
              Icon(
                Icons.favorite_outline_rounded,
                size: 100,
                color: Colors.orange[200],
              ),
              const SizedBox(height: 24),
              const Text(
                'Noch keine Favoriten?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Gehe zum Entdecken-Tab und wische Karten nach rechts, um dir Hobbys für später zu merken.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }

    //Scroll-Liste der favoriesierten Hobbies
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: savedHobbies.length,
      itemBuilder: (context, index) {
        final hobby = savedHobbies[index];

        return Dismissible(
          key: Key(hobby.title),
          //Flutter braucht hier einen einzigartigen Namen

          //Hintergrund beim Wischen nach Rechts (Löschen)
          background: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF4A896),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            margin: const EdgeInsets.only(bottom: 12),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),

          // Hintergrund beim Wischen nach Links (Erledigt!)
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF8D364),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 12),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.white,
              size: 30,
            ),
          ),

          //Was passiert, wenn der Wisch fertig ist?
          onDismissed: (direction) {
            if (direction == DismissDirection.startToEnd) {
              onDelete(hobby); //Nach rechts = weg damit
            } else {
              onComplete(hobby); //Nach links = in den Trophäenraum
            }
          },

          //Die eigentliche Karte
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              onTap: () => _zeigeDetails(context, hobby),
              // HIER ist der Klick für die Details!
              leading: CircleAvatar(
                backgroundColor: const Color(0x8CE5A8F3),
                child: SvgPicture.asset(
                  hobby.svgPath,
                ),
              ),
              title: Text(
                hobby.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                hobby.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}
