import 'package:flutter/material.dart';
import 'Event.dart';
import 'EventMain.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  final List<Map<String, dynamic>> events;

  const EventPage({Key? key, required this.events}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _currentEventIndex = 0;
  bool _hasSwipedAllEvents = false;

  void _changeEvent() {
    if (_currentEventIndex < widget.events.length - 1) {
      setState(() {
        _currentEventIndex++;
      });
    } else {
      setState(() {
        _hasSwipedAllEvents = true;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Fin des événements"),
            content: Text("Vous avez parcouru tous les événements disponibles."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => EventMain(), // Redirection vers MessagesPage
                    ),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasSwipedAllEvents) {
      return Center(
        child: Text(
          "Plus aucun événement à afficher.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    final currentEvent = widget.events[_currentEventIndex];

    return Event(
      eventId: currentEvent['id'].toString(),
      title: currentEvent['name'] ?? "Nom inconnu",
      subtitle: "En concert à ${currentEvent['location'] ?? "Lieu inconnu"} !",
      description: currentEvent['description'] ?? "Pas de description disponible.",
      date: "🗓️ ${currentEvent['date'] != null ? DateFormat('d MMMM', 'fr_FR').format(DateTime.parse(currentEvent['date'])) : "Date inconnue"}",
      image: currentEvent['image'] ?? 'assets/default-image.jpg',
      location: currentEvent['location'] ?? "Inconnu",
      styleOfMusic: currentEvent['style_of_music'] ?? "Inconnu",
      type: currentEvent['type'] ?? "Inconnu",
      onEventChanged: _changeEvent,
    );
  }
}