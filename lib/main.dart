import 'package:flutter/material.dart';
import 'Event.dart'; // Import du widget Event

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Variable pour suivre l'index de l'élément sélectionné

  // Fonction pour changer l'index de la navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(71, 18, 89, 1),
              Color.fromRGBO(20, 20, 20, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Event(
              title: "50 CENT",
              subtitle: "En concert à Paris !",
              description: "🔈 Le légendaire rappeur, producteur et entrepreneur 50 Cent revient à Paris pour un événement inoubliable !",
              date: "🗓️ Dimanche 13 juillet 2025",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        currentIndex: _selectedIndex, // L'index actuellement sélectionné
        onTap: _onItemTapped, // Fonction pour gérer l'événement de tap
        items: <BottomNavigationBarItem>[
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
      ),
    );
  }
}