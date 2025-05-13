import 'package:flutter/material.dart';
import 'Buttons.dart'; // Assurez-vous d'importer le fichier où Buttons est défini
import 'package:dio/dio.dart'; // Ajout de Dio pour la requête HTTP

class Event extends StatelessWidget {
  final String eventId;
  final String title;
  final String subtitle;
  final String description;
  final String date;
  final String image;
  final String location;
  final String styleOfMusic;
  final String type;
  final VoidCallback onEventChanged; // Ajoutez ce callback pour changer d'événement

  const Event({
    Key? key,
    required this.eventId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.date,
    required this.image,
    required this.location,
    required this.styleOfMusic,
    required this.type,
    required this.onEventChanged, // Récupération du callback pour changer d'événement
  }) : super(key: key);

  Future<void> _createParticipation(String action) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://backendbuddies-production.up.railway.app/api/participations',
        data: {
          'personne_id': 1,
          'event_id': eventId,
          'action': action,
        },
      );

      if (response.statusCode == 201) {
        print("Participation enregistrée !");
      } else {
        print("Erreur lors de l'enregistrement de la participation.");
      }
    } catch (e) {
      print("Erreur lors de la requête : $e");
    }
  }

  void _onSwipe(BuildContext context, String action) {
    if (action == "✅ Accepté !") {
      _createParticipation(action);
    }

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

    // Délai d'une seconde avant de changer l'événement
    Future.delayed(Duration(seconds: 1), () {
      onEventChanged(); // Utilisez le callback pour changer d'événement
    });
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
              height: 855,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image), // Utilisez l'image dynamique
                  fit: BoxFit.cover, // Couvre tout l'espace disponible
                ),
              ),
            ),
          ),
          // Titre et sous-titre en premier plan
          Positioned(
            top: MediaQuery.of(context).padding.top +
                MediaQuery.of(context).size.height * 0.025,
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
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(1, 1, 1, 0.6),
                        offset: Offset(7.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                    shadows: [
                      Shadow(
                        color: Color.fromRGBO(1, 1, 1, 0.6),
                        offset: Offset(7.0, 5.0),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                      'text': '📍 $location',
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
                      'text': '🎤 $styleOfMusic',
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
                      'text': '🎫 $type',
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
                      MediaQuery.of(context).size.width * 0.025),
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.2),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}