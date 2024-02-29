import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'dart:developer' as devtools show log;
import '../models/weather_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // API key
  final _weatherService = WeatherService('ff813121369b3dcbf979b0393ac91fdc');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch (e){
      devtools.log(e.toString());
    }

  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(_weather?.cityName ?? "Loading city..."),

          Text("${_weather?.temperature.round()}C")
        ]
      )
    );
  }
}