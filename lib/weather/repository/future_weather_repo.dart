import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:github_project_5_weather_app/app_constant.dart';
import 'package:github_project_5_weather_app/weather/models/future_weather_model.dart';

class FutureWeatherRepo {
  FutureWeatherRepo();
  final Dio dio = Dio();

  Future<Either<String, FutureWeatherModel>> getFutureWeather(
      {required double lat, required double lon}) async {
    try {
      final response = await dio.get(
        'http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=${AppConstant.apiKey}&units=metric',
      );
      if (response.statusCode == 200 ) {
        return Right(FutureWeatherModel.fromJson(response.data));
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
