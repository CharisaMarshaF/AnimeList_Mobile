import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/config/app_config.dart';
import '/models/anime.dart';
import '/models/anime_info.dart';

Future<Iterable<Anime>> getAnimeBySearchApi({
  required String query,
}) async {
  if (query.isEmpty) {
    throw Exception("Query cannot be empty!");
  }

  final baseUrl = 'https://api.myanimelist.net/v2/anime?q=$query&limit=10';

  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'X-MAL-CLIENT-ID': clientId,
      },
    );

    if (response.statusCode == 200) {
      // Proses respons jika sukses
      final Map<String, dynamic> data = json.decode(response.body);
      AnimeInfo animeInfo = AnimeInfo.fromJson(data);
      Iterable<Anime> animes = animeInfo.animes;
      return animes;
    } else {
      // Log error jika respons gaga
      debugPrint("Error: ${response.statusCode}");
      debugPrint("Body: ${response.body}");
      throw Exception("Failed to get data!");
    }
  } catch (e) {
    // Tangkap error
    debugPrint("HTTP request failed: $e");
    throw Exception("Unable to fetch data: $e");
  }
}