import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:github_project_5_weather_app/app_constant.dart';
import 'package:github_project_5_weather_app/weather/models/geo_coor_model.dart';

class GeoCoorRepo {
  GeoCoorRepo();
  final Dio dio = Dio();

  Future<Either<String, GeoCoorModels>> getGeo(
      {required String title, int limit = 1}) async {
    try {
      final response = await dio.get(
        'http://api.openweathermap.org/geo/1.0/direct?q=$title&limit=$limit&appid=${AppConstant.apiKey}',
      );
      if (response.statusCode == 200) {
        return Right(GeoCoorModels.fromJson(response.data));
      }
      return const Left('Fail to get coordinate');
    } on DioException catch (errorMessage) {
      if (errorMessage.response != null) {
        return Left(errorMessage.message!);
      }
      return const Left('Something went wrong, try again later');
    }
  }
}
