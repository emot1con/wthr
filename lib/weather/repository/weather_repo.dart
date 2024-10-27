import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:github_project_5_weather_app/app_constant.dart';
import 'package:github_project_5_weather_app/weather/models/weather_model.dart';

class WeatherRepo {
  WeatherRepo();
  final Dio dio = Dio();

  Future<Either<String, WeatherModel>> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${AppConstant.apiKey}&units=metric',
      );
      if (response.statusCode == 200) {
        return Right(
          WeatherModel.fromJson(response.data),
        );
      }
      return const Left('Fail to get weather');
    } on DioException catch (errorMessage) {
      if (errorMessage.response != null) {
        return Left(errorMessage.message!);
      }
      return const Left('Something went wrong, try again later');
    }
  }
}
