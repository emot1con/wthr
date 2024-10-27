import 'package:flutter/material.dart';

import 'package:github_project_5_weather_app/weather/models/weather_model.dart';
import 'package:github_project_5_weather_app/weather/repository/weather_repo.dart';

class WeatherProvider with ChangeNotifier {
  WeatherProvider();
  final WeatherRepo weatherRepo  = WeatherRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  WeatherModel? _weatherModel;
  WeatherModel? get weatherModel => _weatherModel;

  void getWeather({
    required double lat,
    required double lon,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final result = await weatherRepo.getWeather(lat: lat, lon: lon);
    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _weatherModel = response;
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
