import 'package:anime_list/api/get_anime_by_rangking_type_api.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/screens/view_all_anime.dart';
import 'package:anime_list/widgets/anime_tile.dart';
import 'package:flutter/material.dart';

class AnimeUnggulan extends StatelessWidget {
  const AnimeUnggulan({
    super.key,
    required this.rangkingType,
    required this.label,
    
  });

  final String rangkingType;
  final String label;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAnimeByRangkingTypeApi(rangkingType: rangkingType, limit: 10),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        if (snapshot.data != null) {
          final animes = snapshot.data;

          return Column(
            children: [

              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ViewAllAnime(
                              rangkingType: rangkingType, label: label),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount : animes!.length,
                  separatorBuilder: (context, index){
                    return const SizedBox(width: 10);
                  }, 
                  itemBuilder: (context, index) {
                    final anime = animes.elementAt(index);
                
                    return AnimeTile(
                      anime: anime.node,
                    );
                  },
                ),
              ),
            ],
          );
        }

        return ErrorScreen(error: snapshot.error.toString());
      },
    );
  }
}