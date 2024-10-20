import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherService {
  final String apiKey = '2e5d988c51a55c91dc9eea15a95a2346'; // Replace with your API key

  Future<WeatherResponse?> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception(json.decode(response.body)["message"]??'Error fetching weather data');
      }
    } catch (error) {
      throw Exception('Failed to fetch weather data: $error');
    }
  }
}
