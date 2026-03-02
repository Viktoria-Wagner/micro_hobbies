import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/hobby_data.dart';
import 'custom_bottom_nav.dart';
import '../Favorites/favorites_screen.dart';
import '../Discovery/discover_screen.dart';
import '../Trophies/trophies_screen.dart';
import '../Settings/settings_screen.dart';
import 'package:confetti/confetti.dart';
import '../SharedWidgets/trophy_dialog.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import '../Theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../Theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController cardSwiperController = CardSwiperController();
  List<Hobby> myCards = HobbyDatabase.dummyHobbies;
  List<Hobby> gemerkteHobbies = [];
  List<Hobby> erledigteHobbies = [];
  int _selectedIndex = 0; //Tab, der aktuell ausgewählt ist
  late ConfettiController _confettiController;

  //diese Methode speichert die favorisierten Hobbies (ob durch Swipe oder durch Button)
  bool _wurdeGewischt(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (direction == CardSwiperDirection.right) {
      setState(() {
        gemerkteHobbies.add(myCards[previousIndex]);
      });
      //Pop-Up, dass ein Hobby gemerkt wurde
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${myCards[previousIndex].title} gemerkt! 🥳',
            textAlign: TextAlign.center,
            style: AppTypography.bodyBold.copyWith(color: Colors.white),
          ),
          duration: const Duration(milliseconds: 1000),
          backgroundColor: AppColors.actionGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: AppStyles.radiusLarge,
          ),
          margin: EdgeInsets.only(
            bottom: screenHeight - 170,
            left: 20,
            right: 20,
          ),
        ),
      );
    }
    return true;
  }

  void _hobbyLoeschen(Hobby hobby) {
    setState(() {
      gemerkteHobbies.remove(hobby);
    });
  }

  void _hobbyErledigt(Hobby hobby) {
    setState(() {
      //Auf Einzigartigkeit prüfen, ob ein Hobby mit exakt diesem Titel schon im Schrank steht.
      bool schonVorhanden = erledigteHobbies.any(
        (element) => element.title == hobby.title,
      );

      // Nur hinzufügen, wenn es noch NICHT da ist
      if (!schonVorhanden) {
        erledigteHobbies.add(hobby);
      }
      _starteFeierAnimation(hobby);
      gemerkteHobbies.remove(hobby); // Aus den Favoriten entfernen
    });
  }

  // Diese Methode kümmert sich NUR um die UI und die Effekte
  void _starteFeierAnimation(Hobby hobby) {
    setState(() {
      _selectedIndex = 2; // Zum Trophäen-Tab
    });

    _confettiController.play();

    // HIER IST DIE MAGIE: Der ganze Code ist weg, nur noch der Aufruf bleibt!
    showDialog(
      context: context,
      builder: (BuildContext context) => TrophyDialog(hobby: hobby),
    );
  }

  //gibt jeweiligen Tab zurück
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //diese Methode navigiert zwischen den Tabs der Navigationsleiste
  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return DiscoverScreen(
          controller: cardSwiperController,
          hobbies: myCards,
          onSwipe: _wurdeGewischt,
        );
      case 1:
        return FavoritesScreen(
          savedHobbies: gemerkteHobbies,
          onDelete: _hobbyLoeschen,
          onComplete: _hobbyErledigt,
        );
      case 2:
        return TrophiesScreen(completedHobbies: erledigteHobbies);
      case 3:
        return const SettingsScreen();
      default:
        return Center(
          child: Text(
            'Fehler: Unbekannter Tab',
            style: AppTypography.body.copyWith(color: AppColors.textMuted),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    //sonst wird custom bottom nav nicht sofort geändert, sondern erst nach Verwendung
    context.watch<ThemeProvider>();
    return Scaffold(
      body: Stack(
        children: [
          // 1. EBENE: Deine eigentliche App
          SafeArea(
            child: LazyLoadIndexedStack(
              index: _selectedIndex,
              children: [
                DiscoverScreen(
                  controller: cardSwiperController,
                  hobbies: myCards,
                  onSwipe: _wurdeGewischt,
                ),
                FavoritesScreen(
                  savedHobbies: gemerkteHobbies,
                  onDelete: _hobbyLoeschen,
                  onComplete: _hobbyErledigt,
                ),
                TrophiesScreen(completedHobbies: erledigteHobbies),
                const SettingsScreen(),
              ],
            ),
          ),

          // 2. EBENE: Die Konfetti-Kanone (ganz oben, über allem anderen)
          Align(
            alignment: Alignment.topCenter, // Bleibt oben in der Mitte
            child: ConfettiWidget(
              confettiController: _confettiController,

              //Schießt in einem weiten Bogen nach links und rechts.
              blastDirectionality: BlastDirectionality.explosive,

              //Kraft, damit es bis an die Ränder fliegt
              maxBlastForce: 100,
              minBlastForce: 1,

              //Ein kleinerer Wert sorgt für einen stetigen, gleichmäßigen Fluss
              emissionFrequency: 0.04,

              //Weniger Partikel pro Schuss, dafür kontinuierlich
              numberOfParticles: 150,

              //geringe Schwerkraft, damit es sanft und elegant wie Schnee fällt
              gravity: 0.6,

              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  //schließt die Controller, wenn App beendet wird
  @override
  void dispose() {
    cardSwiperController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Konfetti soll 4 Sekunden lang regnen
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 4),
    );
  }
}
