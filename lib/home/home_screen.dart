import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../providers/hobby_provider.dart';
import '../models/hobby_data.dart';
import '../shared_widgets/custom_bottom_nav.dart';
import '../Favorites/favorites_screen.dart';
import '../Discovery/discover_screen.dart';
import '../Trophies/trophies_screen.dart';
import '../Settings/settings_screen.dart';
import 'package:confetti/confetti.dart';
import '../shared_widgets/trophy_dialog.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import '../Theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CardSwiperController cardSwiperController = CardSwiperController();
  List<Hobby> myCards = HobbyDatabase.dummyHobbies;
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
      context.read<HobbyProvider>().addSavedHobby(myCards[previousIndex]);
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
    context.read<HobbyProvider>().removeSavedHobby(hobby);
  }

  void _hobbyErledigt(Hobby hobby) {
    context.read<HobbyProvider>().addCompletedHobby(hobby);
    _starteFeierAnimation(hobby);
  }

  // Diese Methode kümmert sich NUR um die UI und die Effekte
  void _starteFeierAnimation(Hobby hobby) {
    setState(() {
      _selectedIndex = 2; // Zum Trophäen-Tab
    });

    _confettiController.play();
    _zeigeTrophaeeDialog(hobby);
  }

  void _zeigeTrophaeeDialog(Hobby hobby) {
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

  @override
  Widget build(BuildContext context) {
    //sonst wird custom bottom nav nicht sofort geändert, sondern erst nach Verwendung
    context.watch<ThemeProvider>();
    final hobbyProvider = context.watch<HobbyProvider>();
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
                  savedHobbies: hobbyProvider.savedHobbies, //Daten aus dem Provider
                  onDelete: _hobbyLoeschen,
                  onComplete: _hobbyErledigt,
                ),
                TrophiesScreen(
                  completedHobbies: hobbyProvider.completedHobbies,
                ),
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
