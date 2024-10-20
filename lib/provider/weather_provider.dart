import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherResponse? _weatherResponse;
  String? _errorMessage;

  WeatherResponse? get weatherResponse => _weatherResponse;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    try {
      _weatherResponse = await _weatherService.fetchWeather(city);
      _errorMessage = null; // Clear any previous errors
    } catch (error) {
      _errorMessage = error.toString();
      _weatherResponse = null; // Clear weather response on error
    }

    notifyListeners(); // Notify listeners about the state change
  }
}
