import 'package:anime_list/common/styles/padding.dart';
import 'package:anime_list/views/anime_unggulan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/top_animes_widget.dart';

class AnimesScreen extends StatefulWidget {
  const AnimesScreen({super.key});

  @override
  State<AnimesScreen> createState() => _AnimesScreenState();
}

class _AnimesScreenState extends State<AnimesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime World'),
        
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // anime unggulan 4 saja
            SizedBox(
              height: 300,
              child: TopAnimesList(),
            ),
            //anime teratas
            Padding(
              padding: Paddings.noBottomPadding,
              child: Column(
                children: [
                  // Anime Teratas
                  SizedBox(
                    height: 350,
                    child: AnimeUnggulan(
                      label: 'Top Ranked',
                      rangkingType: 'all',
                    ),
                  ),
                  // Anime Populer
                  SizedBox(
                    height: 350,
                    child: AnimeUnggulan(
                      label: 'Top Popular',
                      rangkingType: 'bypopularity',
                    ),
                  ),
                  // Anime Movie
                  SizedBox(
                    height: 350,
                    child: AnimeUnggulan(
                      label: 'Top Movie',
                      rangkingType: 'movie',
                    ),
                  ),
                  // Anime favorit
                  SizedBox(
                    height: 350,
                    child: AnimeUnggulan(
                      label: 'Top Favorite',
                      rangkingType: 'favorite',
                    ),
                  ),
                  // Anime mendatang
                  SizedBox(
                    height: 350,
                    child: AnimeUnggulan(
                      label: 'Top Upcoming',
                      rangkingType: 'upcoming',
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}