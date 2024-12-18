import 'package:anime_list/common/styles/padding.dart';
import 'package:anime_list/models/anime.dart';
import 'package:anime_list/widgets/anime_list_tile.dart';
import 'package:flutter/material.dart';

class ListPeringkatAnimes extends StatelessWidget {
  const ListPeringkatAnimes({
    super.key,
    required this.animes,
    });
    final Iterable<Anime> animes;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: Paddings.defaultPadding,
    child: ListView.builder(
      itemCount: animes.length,
      itemBuilder: (context, index) {
        final anime = animes.elementAt(index);

        return AnimeListTile(
          anime: anime,
        );
      },
      ),
    );
  }
}