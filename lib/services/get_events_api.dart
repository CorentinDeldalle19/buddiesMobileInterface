import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/eventModel.dart';

class GetEventsAPI {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://backendbuddies-production.up.railway.app/api/events';

  Future<List<Event>> fetchEvents() async {
    try {
      final response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        List<Event> events = (response.data as List)
            .map((eventJson) => Event.fromJson(eventJson))
            .toList();
        return events;
      } else {
        throw Exception('Erreur lors de la récupération des événements');
      }
    } catch (e) {
      debugPrint("Error fetching events: $e");
      rethrow;
    }
  }
}