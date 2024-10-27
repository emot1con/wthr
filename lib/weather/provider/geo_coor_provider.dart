import 'package:flutter/material.dart';

import 'package:github_project_5_weather_app/weather/models/geo_coor_model.dart';
import 'package:github_project_5_weather_app/weather/repository/geo_coor_repo.dart';

class GeoCoorProvider with ChangeNotifier {
  GeoCoorProvider();
  final GeoCoorRepo geoCoorRepo = GeoCoorRepo();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  GeoCoorModels? _geoCoorModel;
  GeoCoorModels? get geoCoorModel => _geoCoorModel;

  void getCoor({
    required String title,
    int limit = 1,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final result = await geoCoorRepo.getGeo(title: title, limit: limit);
    result.fold((errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }, (response) {
      _geoCoorModel = response;
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}
