import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:github_project_5_weather_app/weather/models/geo_coor_model.dart';
import 'package:github_project_5_weather_app/weather/provider/geo_coor_provider.dart';

class SearchPage extends SearchDelegate<GeoCoorModel> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context
            .read<GeoCoorProvider>()
            .getCoor(title: query, context: context, limit: 5);
      });
      return Consumer<GeoCoorProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.geoCoorModel != null) {
            return ListView.builder(
              itemCount: value.geoCoorModel!.geoCoor.length,
              itemBuilder: (context, index) {
                final city = value.geoCoorModel!.geoCoor[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(city);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 39, 38),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              city.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  city.state ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white54),
                                ),
                                Text(
                                  ', ${city.country}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      );
    }
    return const Center(
      child: Text('Search City'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context
            .read<GeoCoorProvider>()
            .getCoor(title: query, context: context, limit: 5
            );
      });
      return Consumer<GeoCoorProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.geoCoorModel != null) {
            return ListView.builder(
              itemCount: value.geoCoorModel!.geoCoor.length,
              itemBuilder: (context, index) {
                final city = value.geoCoorModel!.geoCoor[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(city);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 39, 38),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              city.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  city.state ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white54),
                                ),
                                Text(
                                  ', ${city.country}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      );
    }
    return const Center(
      child: Text('Search City'),
    );
  }
}
