import 'package:flutter/material.dart';
import 'main.dart'; // Assurez-vous d'importer CustomBottomNavBar si nécessaire

class EventMain extends StatefulWidget {
  const EventMain({super.key});

  @override
  State<EventMain> createState() => _EventMainState();
}

class _EventMainState extends State<EventMain> {
  int _selectedIndex = 0; // Index de la page sélectionnée

  final List<Widget> _pages = [
    Center(child: Text("Accueil", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Festival", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Messages", style: TextStyle(color: Colors.white, fontSize: 24))),
    Center(child: Text("Profil", style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  // Fonction pour changer de page
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
        child: _pages[_selectedIndex],
      ),
    );
  }
}