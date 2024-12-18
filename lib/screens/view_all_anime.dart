import 'package:anime_list/api/get_anime_by_rangking_type_api.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/views/list_peringkat_animes.dart';
import 'package:flutter/material.dart';

class ViewAllAnime extends StatelessWidget {
  const ViewAllAnime({
    super.key,
    required this.rangkingType,
    required this.label,
    });
    final String rangkingType;
    final String label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label),),
      body: FutureBuilder(future: getAnimeByRangkingTypeApi(rangkingType: rangkingType, limit: 500), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.data != null){
            return ListPeringkatAnimes(
              animes: snapshot.data!,
            );
          }
          return ErrorScreen(error: snapshot.error.toString());
        },
      ),
    );
  }
}