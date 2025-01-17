import 'dart:convert';

import 'package:anime_list/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/config/app_config.dart';
import '/models/anime.dart';
import '/models/anime_info.dart';

Future<Iterable<Anime>> getSeasonalAnimesApi({
  required int limit,
}) async {
  final year = DateTime.now().year;
  final season = getCurrentSeason();
  final baseUrl = 
      'https://api.myanimelist.net/v2/anime/season/$year/$season?limit=$limit';

  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      'X-MAL-CLIENT-ID': clientId,
    },
  );
  if (response.statusCode == 200){
    //sukses
      final Map<String, dynamic> data = json.decode(response.body);
      final seasonalAnime = AnimeInfo.fromJson(data);

      return seasonalAnime.animes;
  } else {
    //eror
    debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");
    throw Exception("Failed to get data!");
  } 
} 
