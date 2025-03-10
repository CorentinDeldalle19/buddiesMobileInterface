import 'package:flutter/material.dart';
import 'Event.dart';
import 'EventMain.dart';

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

  final List<Widget> _pages = [
    Event(
      title: "50 CENT",
      subtitle: "En concert à Paris !",
      description: "🔈 Le légendaire rappeur, producteur et entrepreneur 50 Cent revient à Paris pour un événement inoubliable !",
      date: "🗓️ Dimanche 13 juillet 2025",
    ),
    EventMain(),
    Container(color: Colors.blue),
    Container(color: Colors.green),
  ];

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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}