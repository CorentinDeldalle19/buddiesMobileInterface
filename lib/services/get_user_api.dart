import 'package:dio/dio.dart';

class userData {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      Response response = await _dio.get('https://backendbuddies-production.up.railway.app/api/personnes/1');
      return response.data;
    } catch (e) {
      throw Exception('Failed to load user data');
    }
  }
}