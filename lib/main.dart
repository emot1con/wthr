import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:github_project_5_weather_app/weather/provider/future_weather_provider.dart';
import 'package:github_project_5_weather_app/weather/provider/weather_provider.dart';
import 'package:github_project_5_weather_app/weather/pages/home_page.dart';
import 'package:github_project_5_weather_app/weather/provider/geo_coor_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GeoCoorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FutureWeatherProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: const ColorScheme.dark()),
        home: const HomePage(),
      ),
    );
  }
}
