import 'package:flutter/material.dart';

@immutable
class AnimeKategori {
  final String title;
  final String rankingType;

  const AnimeKategori({
    required this.title,
    required this.rankingType,
  });

  factory AnimeKategori.fromJson(Map<String, dynamic> json) {
    return AnimeKategori(
      title: json['title'],
      rankingType: json['rankingType'],
    );
  }
}

const animeKategorii = [
  AnimeKategori(title: 'Top Anime', rankingType: 'all'),
  AnimeKategori(title: 'Top Airing', rankingType: 'airing'),
  AnimeKategori(title: 'Top Upcoming', rankingType: 'upcoming'),
  AnimeKategori(title: 'Top TV Series', rankingType: 'tv'),
  AnimeKategori(title: 'Top OVA', rankingType: 'ova'),
  AnimeKategori(title: 'Top Movies', rankingType: 'movie'),
  AnimeKategori(title: 'Top Specials', rankingType: 'special'),
  AnimeKategori(title: 'Top Popular', rankingType: 'bypopularity'),
  AnimeKategori(title: 'Top Favorited', rankingType: 'favorite'),
];