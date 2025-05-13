import 'package:dio/dio.dart';

class GetParticipations {
  final Dio _dio = Dio();
  final String baseUrl = 'hhttps://backendbuddies-production.up.railway.app/api/participations/allParticipations';

  Future<List<dynamic>> fetchEvents() async {
    try {
      Response response = await _dio.get('$baseUrl');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load events');
      }
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }
}