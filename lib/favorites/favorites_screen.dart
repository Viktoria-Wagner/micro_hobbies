import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/hobby_data.dart';
import '../shared_widgets/info_badge.dart';
import '../theme/app_theme.dart';

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
      backgroundColor: AppColors.backgroundPastel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          // Padding unten sorgt dafür, dass die Navigation/home-Leiste des Handys nichts verdeckt
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 24.0,
            bottom: MediaQuery.of(context).padding.bottom + 24.0,
          ),
          child: SingleChildScrollView( // Macht den Inhalt scrollbar, falls der Text sehr lang ist
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start, // Richtet Texte linksbündig aus
              children: [

                //Der Titel
                Center(
                  child: Text(
                    hobby.title,
                    textAlign: TextAlign.center,
                    style: AppTypography.headlineLarge,
                  ),
                ),
                const SizedBox(height: 16),

                //Die Info-Badges
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      InfoBadge(
                          icon: Icons.category,
                          text: hobby.category,
                          bgColor: Colors.orangeAccent.withAlpha(77),
                          textColor: Colors.orange[900]!
                      ),
                      InfoBadge(
                          icon: Icons.schedule,
                          text: hobby.time,
                          bgColor: Colors.blueAccent.withAlpha(77),
                          textColor: Colors.blue[900]!
                      ),
                      InfoBadge(
                        icon: Icons.bolt,
                        text: hobby.difficulty.label,
                        bgColor: hobby.difficulty.baseColor.withAlpha(51),
                        textColor: hobby.difficulty.baseColor[800]!,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                Divider(color: AppColors.dividerLight, thickness: 2),
                const SizedBox(height: 16),

                //Die Kurzbeschreibung als Einleitung
                Text(
                  hobby.description,
                  style:   AppTypography.descriptionItalic
                ),
                const SizedBox(height: 24),

                //Materialien
                Text(
                  'Das brauchst du:',
                  style: AppTypography.highlightText,
                ),
                const SizedBox(height: 8),
                Text(
                  '• ${hobby.materials}',
                  style: AppTypography.body,
                ),
                const SizedBox(height: 24),

                //Die detaillierte Anleitung
                Text(
                  'So geht\'s:',
                  style: AppTypography.highlightText,
                ),
                const SizedBox(height: 8),
                Text(
                  hobby.details,
                  style: AppTypography.body,
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
              Text(
                'Noch keine Favoriten?',
                style: AppTypography.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Gehe zum Entdecken-Tab und wische Karten nach rechts, um dir Hobbys für später zu merken.',
                textAlign: TextAlign.center,
                style:AppTypography.body.copyWith(color: AppColors.textMuted),
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
              color: AppColors.actionRed,
              borderRadius: AppStyles.radiusSmall,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            margin: const EdgeInsets.only(bottom: 12),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),

          // Hintergrund beim Wischen nach Links (Erledigt!)
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: AppColors.actionYellow,
              borderRadius: AppStyles.radiusSmall,
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
              borderRadius: AppStyles.radiusSmall,
            ),
            child: ListTile(
              onTap: () => _zeigeDetails(context, hobby),
              // HIER ist der Klick für die Details!
              leading: CircleAvatar(
                backgroundColor: AppColors.avatarPurple,
                child: SvgPicture.asset(
                  hobby.svgPath,
                ),
              ),
              title: Text(
                hobby.title,
                style: AppTypography.bodyBold,
              ),
              subtitle: Text(
                hobby.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.subtitle,
              ),
            ),
          ),
        );
      },
    );
  }
}
