import 'package:flutter/foundation.dart' show immutable;

import '/models/anime_node.dart';
import '/models/picture.dart';

class AnimeDetails {
  final int id; // ID unik untuk anime
  final String title; // Judul anime
  final Picture mainPicture; // Gambar utama dari anime
  final AlternativeTitles alternativeTitles; // Judul alternatif anime
  final String startDate; // Tanggal mulai tayang anime
  final String endDate; // Tanggal akhir tayang anime (jika ada)
  final String synopsis; // Deskripsi singkat tentang anime

  final dynamic mean; // Rating, bisa berupa int atau double
  final int rank; // Peringkat anime berdasarkan popularitas atau skor
  final int popularity; // Skor popularitas (jumlah orang yang menambahkannya ke daftar)
  final int numListUsers; // Jumlah pengguna yang menambahkan anime ke daftar mereka
  final int numScoringUsers; // Jumlah pengguna yang memberi skor pada anime
  final String nsfw; // Menandakan apakah anime mengandung konten NSFW
  final String createdAt; // Tanggal anime ditambahkan ke database
  final String updatedAt; // Tanggal terakhir kali data anime diperbarui
  final String mediaType; // Jenis media (misalnya, TV, Film)
  final String status; // Status anime (misalnya, tayang, selesai)
  final List<Genre> genres; // Daftar genre yang dimiliki anime
  final int numEpisodes; // Jumlah episode dalam anime
  final StartSeason startSeason; // Musim dan tahun anime mulai tayang

  final Broadcast? broadcast; // Informasi siaran (null untuk film)
  final String source; // Sumber dari anime (misalnya, manga, novel ringan)
  final int averageEpisodeDuration; // Durasi rata-rata setiap episode dalam menit
  final String rating; // Rating (misalnya, PG-13, R)
  final List<Picture> pictures; // Gambar tambahan terkait anime
  final String background; // Gambar atau deskripsi latar belakang
  final List<RelatedAnime> relatedAnime; // Daftar anime terkait
  final List<dynamic> relatedManga; // Daftar manga terkait
  final List<Recommendation> recommendations; // Rekomendasi anime serupa
  final List<Studio> studios; // Daftar studio yang mengerjakan anime
  final Statistics statistics; // Statistik terkait anime

  const AnimeDetails({
    required this.id,
    required this.title,
    required this.mainPicture,
    required this.alternativeTitles,
    required this.startDate,
    required this.endDate,
    required this.synopsis,
    required this.mean,
    required this.rank,
    required this.popularity,
    required this.numListUsers,
    required this.numScoringUsers,
    required this.nsfw,
    required this.createdAt,
    required this.updatedAt,
    required this.mediaType,
    required this.status,
    required this.genres,
    required this.numEpisodes,
    required this.startSeason,
    this.broadcast,
    required this.source,
    required this.averageEpisodeDuration,
    required this.rating,
    required this.pictures,
    required this.background,
    required this.relatedAnime,
    required this.recommendations,
    required this.studios,
    required this.statistics,
    required this.relatedManga,
  });

  factory AnimeDetails.fromJson(Map<String, dynamic> json) {
    return AnimeDetails(
      id: json['id'], // ID anime
      title: json['title'], // Judul anime
      mainPicture: Picture.fromJson(json['main_picture']), // Gambar utama anime
      alternativeTitles: AlternativeTitles.fromJson(json['alternative_titles']), // Judul alternatif
      startDate: json['start_date'] ?? 'Unknown', // Tanggal mulai (jika tidak ada, 'Unknown')
      endDate: json['end_date'] ?? 'Unknown', // Tanggal selesai (jika tidak ada, 'Unknown')
      synopsis: json['synopsis'], // Deskripsi anime
      mean: json['mean'] ?? 0.0, // Rating, default 0.0 jika tidak ada
      rank: json['rank'] ?? 0, // Peringkat anime, default 0 jika tidak ada
      popularity: json['popularity'], // Skor popularitas
      numListUsers: json['num_list_users'], // Jumlah pengguna yang menambahkannya ke daftar
      numScoringUsers: json['num_scoring_users'], // Jumlah pengguna yang memberi skor
      nsfw: json['nsfw'], // Menandakan apakah anime mengandung konten NSFW
      createdAt: json['created_at'], // Waktu pembuatan data
      updatedAt: json['updated_at'], // Waktu pembaruan data
      mediaType: json['media_type'], // Jenis media (TV, Film, dll.)
      status: json['status'], // Status anime (misalnya, 'Airing', 'Finished')
      genres: List<Genre>.from( // Daftar genre yang dimiliki anime
        json['genres'].map((genre) => Genre.fromJson(genre)),
      ),
      numEpisodes: json['num_episodes'], // Jumlah episode
      startSeason: json['start_season'] != null // Jika ada musim mulai, parse data musimnya
          ? StartSeason.fromJson(json['start_season'])
          : const StartSeason(year: 2000, season: 'Unknown'), // Default musim jika tidak ada data
      broadcast: json['broadcast'] != null // Jika ada info siaran, parse data siaran
          ? Broadcast.fromJson(json['broadcast'])
          : null,
      source: json['source'], // Sumber anime (manga, novel, dll.)
      averageEpisodeDuration: json['average_episode_duration'], // Durasi rata-rata episode
      rating: json['rating'], // Rating anime
      pictures: List<Picture>.from( // Daftar gambar anime
        json['pictures'].map((picture) => Picture.fromJson(picture)),
      ),
      background: json['background'], // Gambar atau deskripsi latar belakang
      relatedAnime: List<RelatedAnime>.from( // Daftar anime terkait
        json['related_anime'].map((anime) => RelatedAnime.fromJson(anime)),
      ),
      relatedManga: json['related_manga'], // Daftar manga terkait
      recommendations: List<Recommendation>.from( // Rekomendasi anime serupa
        json['recommendations'].map((rec) => Recommendation.fromJson(rec)),
      ),
      studios: List<Studio>.from( // Daftar studio yang mengerjakan anime
        json['studios'].map((studio) => Studio.fromJson(studio)),
      ),
      statistics: Statistics.fromJson(json['statistics']), // Statistik terkait anime
    );
  }
}


@immutable
class AlternativeTitles {
  final List<String> synonyms; // Daftar sinonim judul
  final String en; // Judul dalam bahasa Inggris
  final String ja; // Judul dalam bahasa Jepang

  const AlternativeTitles({
    required this.synonyms,
    required this.en,
    required this.ja,
  });

  factory AlternativeTitles.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek AlternativeTitles
    return AlternativeTitles(
      synonyms: List<String>.from(json['synonyms']),
      en: json['en'],
      ja: json['ja'],
    );
  }
}

@immutable
class Genre {
  final int id; // ID genre
  final String name; // Nama genre

  const Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Genre
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}

@immutable
class StartSeason {
  final int year; // Tahun rilis anime
  final String season; // Musim rilis anime

  const StartSeason({
    required this.year,
    required this.season,
  });

  factory StartSeason.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek StartSeason
    return StartSeason(
      year: json['year'],
      season: json['season'],
    );
  }
}

@immutable
class Broadcast {
  final String dayOfWeek; // Hari siaran
  final String startTime; // Waktu mulai siaran

  const Broadcast({
    required this.dayOfWeek,
    required this.startTime,
  });

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Broadcast
    return Broadcast(
      dayOfWeek: json['day_of_the_week'],
      startTime: json['start_time'],
    );
  }
}

@immutable
class RelatedAnime {
  final AnimeNode node; // Objek AnimeNode terkait
  final String relationType; // Jenis hubungan (misalnya: 'prequel')
  final String relationTypeFormatted; // Hubungan yang diformat

  const RelatedAnime({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedAnime.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek RelatedAnime
    return RelatedAnime(
      node: AnimeNode.fromJson(json['node']),
      relationType: json['relation_type'],
      relationTypeFormatted: json['relation_type_formatted'],
    );
  }
}

@immutable
class RelatedManga {
  final AnimeNode node; // Objek AnimeNode terkait dengan manga
  final String relationType; // Jenis hubungan manga
  final String relationTypeFormatted; // Hubungan manga yang diformat

  const RelatedManga({
    required this.node,
    required this.relationType,
    required this.relationTypeFormatted,
  });

  factory RelatedManga.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek RelatedManga
    return RelatedManga(
      node: AnimeNode.fromJson(json['node']),
      relationType: json['relation_type'],
      relationTypeFormatted: json['relation_type_formatted'],
    );
  }
}

@immutable
class Recommendation {
  final AnimeNode node; // Anime yang direkomendasikan
  final int numRecommendations; // Jumlah rekomendasi

  const Recommendation({
    required this.node,
    required this.numRecommendations,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Recommendation
    return Recommendation(
      node: AnimeNode.fromJson(json['node']),
      numRecommendations: json['num_recommendations'],
    );
  }
}

@immutable
class Studio {
  final int id; // ID studio
  final String name; // Nama studio

  const Studio({
    required this.id,
    required this.name,
  });

  factory Studio.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Studio
    return Studio(
      id: json['id'],
      name: json['name'],
    );
  }
}

@immutable
class Statistics {
  final Status status; // Status statistik anime
  final int numListUsers; // Jumlah pengguna yang menambahkan anime ke daftar mereka

  const Statistics({
    required this.status,
    required this.numListUsers,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Statistics
    return Statistics(
      status: Status.fromJson(json['status']),
      numListUsers: json['num_list_users'],
    );
  }
}

@immutable
class Status {
  final dynamic watching; // Status menonton
  final dynamic completed; // Status selesai menonton
  final dynamic onHold; // Status menunggu
  final dynamic dropped; // Status dibatalkan
  final dynamic planToWatch; // Status rencana menonton

  const Status({
    required this.watching,
    required this.completed,
    required this.onHold,
    required this.dropped,
    required this.planToWatch,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    // Mengonversi data JSON menjadi objek Status
    return Status(
      watching: json['watching'],
      completed: json['completed'],
      onHold: json['on_hold'],
      dropped: json['dropped'],
      planToWatch: json['plan_to_watch'],
    );
  }
}
