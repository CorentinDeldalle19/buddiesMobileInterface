import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Event.dart';
import 'EventMain.dart';
import 'MessagesPage.dart';
import 'AccountPage.dart';
import 'EventsPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'fr_FR'; // Définit la locale par défaut
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
      ],
      home: const MyHomePage(),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/home-modified.png', width: 24, height: 24),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/festival-modified.png', width: 24, height: 24),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/messenger-modified.png', width: 24, height: 24),
          label: ' ',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/user-modified.png', width: 24, height: 24),
          label: ' ',
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> events = []; // Stocke les événements récupérés depuis l'API
  List<Widget> _pages = []; // Pages pour la barre inférieure

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  String formatDateToDayMonth(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      final formatter = DateFormat('d MMMM', 'fr_FR');
      return formatter.format(dateTime);
    } catch (e) {
      print('Erreur de parsing de date : $e');
      return "Date inconnue";
    }
  }

  Future<void> _fetchEvents() async {
    try {
      final dio = Dio();
      print('Appel de l\'API...');
      final response = await dio.get('https://backendbuddies-production.up.railway.app/api/events');

      if (response.statusCode == 200) {
        setState(() {
          events = List<Map<String, dynamic>>.from(response.data);

          // Initialisation des pages une fois les événements chargés
          _pages = [
            EventPage(events: events), // Page des événements avec gestion du swipe
            const EventMain(), // Page principale des événements
            MessagesPage(), // Page de messagerie
            AccountPage(), // Page de gestion du compte
          ];
        });
        print('Données récupérées : $events');
      } else {
        print('Échec API : Code ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Contenu de _pages : $_pages'); // Débogage pour voir le contenu
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(71, 18, 89, 1),
              Color.fromRGBO(20, 20, 20, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _pages.isNotEmpty
            ? _pages[_selectedIndex]
            : const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}