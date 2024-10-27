import 'package:flutter/material.dart';

import 'package:github_project_5_weather_app/weather/models/future_weather_model.dart';
import 'package:github_project_5_weather_app/weather/repository/future_weather_repo.dart';

class FutureWeatherProvider with ChangeNotifier {
  FutureWeatherProvider();
  final FutureWeatherRepo futureWeatherRepo = FutureWeatherRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  FutureWeatherModel? _futureWeatherModel;
  FutureWeatherModel? get futureWeatherModel => _futureWeatherModel;

  void getFutureWeather({
    required double lat,
    required double lon,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final result = await futureWeatherRepo.getFutureWeather(lat: lat, lon: lon);
    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _futureWeatherModel = response;
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
