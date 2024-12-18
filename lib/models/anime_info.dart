import 'package:flutter/foundation.dart' show immutable;
import '/models/anime.dart';

@immutable 
class AnimeInfo {
  final Iterable<Anime> animes;

  const AnimeInfo({
    required this.animes,
  });

  factory AnimeInfo.fromJson(Map<String, dynamic> json) {
    List<dynamic> animeRangkingList = json['data'];
    List<Anime> animeRangkingItems = animeRangkingList
      .map(
        (item) => Anime.fromJson(item),
      )
      .toList();
    return AnimeInfo(
      animes: animeRangkingItems,
    );
  }
}

@immutable

class Rangking {
  final int rank;

  const Rangking({
    required this.rank,
  });

  factory Rangking.fromJson(Map<String, dynamic> json) {
    return Rangking(
      rank: json['rank'],
    );
  }
}