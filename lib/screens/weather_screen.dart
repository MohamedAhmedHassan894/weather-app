import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter city name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String city = _controller.text;
                weatherProvider.fetchWeather(city);
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            weatherProvider.weatherResponse != null
                ? Column(
              children: [
                Text('City: ${weatherProvider.weatherResponse!.name}'),
                Text('Temperature: ${weatherProvider.weatherResponse!.main?.temp}°C'),
                Text('Description: ${weatherProvider.weatherResponse!.weather![0].description}'),
                Image.network(
                  'https://openweathermap.org/img/w/${weatherProvider.weatherResponse!.weather![0].icon}.png',
                ),
              ],
            )
                : weatherProvider.errorMessage != null
                ? Text(weatherProvider.errorMessage!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
