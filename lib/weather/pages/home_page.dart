import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:github_project_5_weather_app/weather/models/geo_coor_model.dart';
import 'package:github_project_5_weather_app/weather/pages/search_page.dart';
import 'package:github_project_5_weather_app/app_constant.dart';
import 'package:github_project_5_weather_app/weather/provider/future_weather_provider.dart';
import 'package:github_project_5_weather_app/weather/provider/geo_coor_provider.dart';
import 'package:github_project_5_weather_app/weather/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleGeoCoor =
      TextEditingController(text: 'london');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<GeoCoorProvider>().getCoor(
            title: titleGeoCoor.text,
            context: context,
            limit: 1,
          );
      context.read<WeatherProvider>().getWeather(
            lat: double.parse(AppConstant.lat),
            lon: double.parse(AppConstant.lon),
            context: context,
          );
      context.read<FutureWeatherProvider>().getFutureWeather(
            lat: double.parse(AppConstant.lat),
            lon: double.parse(AppConstant.lon),
            context: context,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              const WeatherComponent(),
              Positioned(
                top: 10,
                right: 10,
                child: SizedBox(
                  height: 55,
                  width: 55,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(116, 85, 84, 84),
                    child: IconButton(
                      onPressed: () async {
                        final data = await showSearch<GeoCoorModel>(
                          context: context,
                          delegate: SearchPage(),
                        );
                        if (data != null && context.mounted) {
                          context.read<WeatherProvider>().getWeather(
                                lat: data.lat,
                                lon: data.lon,
                                context: context,
                              );
                              print(data.state);
                          context
                              .read<FutureWeatherProvider>()
                              .getFutureWeather(
                                lat: data.lat,
                                lon: data.lon,
                                context: context,
                              );
                          context.read<GeoCoorProvider>().getCoor(
                                title: data.name,
                                context: context,
                                limit: 1
                              );
                        }
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherComponent extends StatelessWidget {
  const WeatherComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GeoCoorProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(137, 82, 79, 79),
            ),
          );
        }
        if (value.geoCoorModel != null) {
          return ListView.builder(
            itemCount: value.geoCoorModel!.geoCoor.length,
            itemBuilder: (context, index) {
              final geoCoor = value.geoCoorModel!.geoCoor[index];
              return Column(
                children: [
                  Consumer<WeatherProvider>(
                    builder: (context, value, child) {
                      final weather = value.weatherModel;
                      if (value.isLoading) {
                        return Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(137, 82, 79, 79),
                          ),
                        );
                      }
                      if (value.weatherModel != null) {
                        final int temp = value.weatherModel!.main.temp.floor();
                        return Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 39, 39, 38),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 39, 39, 38),
                                blurRadius: 0.2,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: Image.asset(
                                          'assets/images/${value.weatherModel!.weather[index].icon}.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          weather!.weather[index].main,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${geoCoor.name}, ${geoCoor.state}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white54,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '$temp°C',
                                          style: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.speed),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(weather.wind.speed
                                                    .toString()),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.visibility),
                                                const SizedBox(
                                                  width: 3,
                                                ),
                                                Text(weather.visibility
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: Text('No data found'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer<FutureWeatherProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(137, 82, 79, 79),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        );
                      }
                      if (value.futureWeatherModel != null) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              value.futureWeatherModel!.list.map((fWeather) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 39, 39, 38),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/images/${fWeather.weather[0].icon}.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          fWeather.weather[0].main,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          fWeather.weather[0].description,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white54),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(Icons.timelapse),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              fWeather.dtTxt
                                                  .toString()
                                                  .substring(11, 16),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${fWeather.main.temp.floor().toString()}°C',
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.wind_power,
                                              color: Colors.white54,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              fWeather.wind.speed.toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white54),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                      return const SizedBox();
                    },
                  )
                ],
              );
            },
          );
        }
        return const Center(
          child: Text('No data found'),
        );
      },
    );
  }
}
