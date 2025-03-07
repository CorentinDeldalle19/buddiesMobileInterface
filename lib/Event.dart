import 'package:flutter/material.dart';
import 'Buttons.dart'; // Assurez-vous d'importer le fichier où Buttons est défini

class Event extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String date;

  const Event({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date});

  void _onSwipe(BuildContext context, String action) {
    final snackBar = SnackBar(
      content: Text(
        action,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.7),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! > 0) {
          _onSwipe(context, "✅ Accepté !");
        } else if (details.primaryVelocity! < 0) {
          _onSwipe(context, "❌ Refusé !");
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          // Image en arrière-plan avec opacité
          Opacity(
            opacity: 0.75,
            child: Container(
              width: double.infinity,
              height: 855, // Légère réduction de la hauteur pour remonter l'ensemble
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/50cent.jpeg'),
                  fit: BoxFit.cover, // Couvre tout l'espace disponible
                ),
              ),
            ),
          ),
          // Titre et sous-titre en premier plan
          Positioned(
            top: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.025,
            left: MediaQuery.of(context).size.height * 0.02,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 58,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          // Ajout du composant Buttons + Textes
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Buttons(
                  buttonProps: [
                    {
                      'text': '📍 Accor Arena',
                      'backgroundColor': Color.fromRGBO(255, 255, 117, 0.6),
                      'borderColor': Color.fromRGBO(255, 255, 117, 1),
                      'borderWidth': 2.0,
                      'boxShadow': [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 117, 0.6),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    },
                    {
                      'text': '🎤 Hip-Hop/Rap',
                      'backgroundColor': Color.fromRGBO(246, 117, 255, 0.6),
                      'borderColor': Color.fromRGBO(246, 61, 255, 1.0),
                      'borderWidth': 2.0,
                      'boxShadow': [
                        BoxShadow(
                          color: Color.fromRGBO(246, 117, 255, 0.6),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    },
                    {
                      'text': '🎫 Concert',
                      'backgroundColor': Color.fromRGBO(117, 181, 255, 0.6),
                      'borderColor': Color.fromRGBO(117, 181, 255, 1),
                      'borderWidth': 2.0,
                      'boxShadow': [
                        BoxShadow(
                          color: Color.fromRGBO(117, 181, 255, 0.6),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    },
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.025
                  ),
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.2
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6), // Fond noir semi-transparent
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow( // Ajout de BoxShadow() pour éviter l'erreur
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche des textes
                    children: [
                      Text(
                        description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        date,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}