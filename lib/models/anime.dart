import 'package:flutter/foundation.dart' show immutable;

import '/models/anime_info.dart';
import '/models/anime_node.dart';

@immutable 
class Anime {
  // Variabel yang menyimpan data AnimeNode 
  final AnimeNode node;
  
  // Variabel opsional yang menyimpan informasi peringkat anime, bisa null jika tidak ada.
  final Rangking? rangking;

  // Konstruktor untuk kelas Anime, menerima parameter node (wajib) dan rangking (opsional).
  const Anime({
    required this.node,  // Harus ada nilai node ketika objek Anime dibuat.
    this.rangking,      // Rangking opsional, bisa null.
  });
  
  // Factory constructor untuk membuat objek Anime dari data JSON (map) yang diberikan.
  factory Anime.fromJson(Map<String, dynamic> json){
    // Mengembalikan objek Anime dengan mengonversi data JSON.
    return Anime(
      // Mengonversi data JSON untuk 'node' menjadi objek AnimeNode menggunakan metode FromJson.
      node: AnimeNode.fromJson(json['node']),
      
      // Mengonversi data JSON untuk 'rangking' menjadi objek Rangking jika ada.
      // Jika 'rangking' tidak ada di JSON, maka nilai rangking akan null.
      rangking: 
      json['rangking'] != null ? Rangking.fromJson(json['rangking']) : null,
    );
  }
}
