//Die Bauanleitung für ein Hobby
class Hobby {
  final String title;
  final String description;
  final String details;
  final String svgPath;
  final String time;
  final String materials;
  final String category;
  final String difficulty;

  Hobby({
    required this.title,
    required this.description,
    required this.details,
    required this.svgPath,
    required this.time,
    required this.materials,
    required this.category,
    required this.difficulty,
  });
}

//Unsere statische Datenbank
class HobbyDatabase {
  static final List<Hobby> dummyHobbies = [
    Hobby(
      title: 'Jonglieren',
      description: 'Lerne die absolute Basis: Die 3-Ball-Kaskade.',
      details:
          'Jonglieren fördert die Verknüpfung beider Gehirnhälften und baut Stress ab. Beginne mit einem Ball, nimm dann den zweiten dazu und versuche sie in einem X-Muster zu werfen, bevor du den dritten Ball integrierst.',
      svgPath: 'assets/svg/juggler-svgrepo-com.svg',
      time: '30 Min',
      materials: '3 weiche Bälle (oder zusammengerollte Socken)',
      category: 'Geschicklichkeit',
      difficulty: 'mittel',
    ),
    Hobby(
      title: 'Origami Kranich',
      description: 'Falte das internationale Symbol für Frieden.',
      details:
          'Der Papierkranich (Orizuru) ist ein Klassiker. Wer der Legende nach 1000 Kraniche faltet, hat einen Wunsch frei. Achte auf saubere Kanten für ein perfektes Ergebnis!',
      svgPath: 'assets/svg/origami-svgrepo-com.svg',
      time: '15 Min',
      materials: 'Ein quadratisches Blatt Papier',
      category: 'Kreativität',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Sauerteig ansetzen',
      description: 'Züchte dein eigenes Haustier für leckeres Brot.',
      details:
          'Ein Sauerteig-Starter braucht nur Wasser und Mehl. Er fängt wilde Hefen aus der Luft ein. Du musst ihn jeden Tag füttern, bis er nach ein paar Tagen blubbert und nach Hefe duftet.',
      svgPath: 'assets/svg/bread-svgrepo-com.svg',
      time: '5 Min (täglich)',
      materials: 'Roggenmehl, Wasser, ein sauberes Einmachglas',
      category: 'Kochen & Backen',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Kalt Duschen',
      description: 'Wecke deine Lebensgeister mit dem Wim-Hof-Effekt.',
      details:
          'Kaltes Wasser am Morgen stärkt das Immunsystem und sorgt für einen massiven Dopamin-Schub. Beginne mit deiner normalen warmen Dusche und stelle das Wasser für die letzten 30 Sekunden auf eiskalt.',
      svgPath: 'assets/svg/showers-water-svgrepo-com.svg',
      time: '5 Min',
      materials: 'Eine Dusche, ein Handtuch, etwas Mut',
      category: 'Gesundheit',
      difficulty: 'mittel',
    ),
    Hobby(
      title: 'Makramee Feder',
      description: 'Knüpfe eine wunderschöne Boho-Feder für deine Wand.',
      details:
          'Makramee ist eine orientalische Knüpftechnik. Für eine Feder brauchst du nur den einfachen Kreuzknoten. Am Ende wird das Garn ausgekämmt, damit es buschig wie eine echte Feder wirkt.',
      svgPath: 'assets/svg/feather-svgrepo-com.svg',
      time: '45 Min',
      materials: 'Makramee-Garn, Schere, Kamm',
      category: 'DIY',
      difficulty: 'mittel',
    ),
    Hobby(
      title: 'Sternbilder finden',
      description: 'Lerne 3 Sternbilder an deinem Nachthimmel kennen.',
      details:
          'Neben dem Großen Wagen gibt es viel zu entdecken. Suche dir den Polarstern, um Cassiopeia zu finden, oder halte nach dem Gürtel des Orion Ausschau. Eine Sternen-App hilft dir am Anfang.',
      svgPath: 'assets/svg/stars-svgrepo-com.svg',
      time: '20 Min',
      materials: 'Klarer Himmel, evt. eine Astronomie-App',
      category: 'Natur & Wissen',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Geocaching',
      description: 'Geh auf moderne digitale Schatzsuche in deiner Stadt.',
      details:
          'Überall auf der Welt sind kleine "Caches" (Dosen) versteckt. Mit den GPS-Koordinaten machst du dich auf die Suche. Hast du einen gefunden, trägst du dich ins kleine Logbuch ein.',
      svgPath: 'assets/svg/map-svgrepo-com.svg',
      time: '1 Stunde',
      materials: 'Smartphone mit GPS, ein Stift',
      category: 'Outdoor',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Achtsamkeit',
      description: 'Finde 10 Minuten absolute innere Ruhe.',
      details:
          'Setze dich bequem hin, schließe die Augen und konzentriere dich nur auf deinen Atem. Wenn Gedanken aufkommen, ärgere dich nicht, sondern lass sie wie Wolken weiterziehen.',
      svgPath: 'assets/svg/meditation-svgrepo-com.svg',
      time: '10 Min',
      materials: 'Ein ruhiger Ort',
      category: 'Mentale Gesundheit',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Gemüse fermentieren',
      description: 'Mache dein eigenes gesundes probiotisches Sauerkraut.',
      details:
          'Hobel etwas Weißkohl, knete ihn kräftig mit Salz durch, bis Saft austritt, und presse ihn fest in ein Glas. Die Milchsäurebakterien erledigen den Rest und machen es haltbar und extrem gesund!',
      svgPath: 'assets/svg/jar-jam-svgrepo-com.svg',
      time: '30 Min (dann warten)',
      materials: 'Weißkohl, Salz, Einmachglas',
      category: 'Kochen & Backen',
      difficulty: 'leicht',
    ),
    Hobby(
      title: 'Kalligraphie Basics',
      description:
          'Schreibe deinen Namen in wunderschönen, geschwungenen Buchstaben.',
      details:
          'Die goldene Regel des Handletterings: Bewegungen nach oben zeichnest du mit ganz leichtem Druck, Bewegungen nach unten mit festem Druck. So entsteht der typische dicke und dünne Pinsel-Look.',
      svgPath: 'assets/svg/pen-writer-svgrepo-com.svg',
      time: '30 Min',
      materials: 'Brush-Pen (Pinselstift) oder weicher Bleistift, Papier',
      category: 'Kunst',
      difficulty: 'mittel',
    ),
    Hobby(
      title: 'Freihändiger Handstand',
      description: 'Meistere die ultimative Körperkontrolle und Balance.',
      details: 'Ein freier Handstand erfordert enorme Rumpf- und Schulterkraft sowie unzählige Stunden des Balancetrainings. Beginne mit dem Bauch zur Wand, lerne das sichere Abrollen bei einem Sturz und arbeite dich Millimeter für Millimeter in die freie Balance vor. Rückschläge sind Teil des Prozesses!',
      svgPath: 'assets/svg/acrobatic-svgrepo-com.svg',
      time: 'Wochen bis Monate (15 Min/Tag)',
      materials: 'Eine weiche Matte, eine Wand und extrem viel Geduld',
      category: 'Sport & Akrobatik',
      difficulty: 'schwer',
    ),
  ];
}
