import 'package:anime_list/api/get_anime_details_api.dart';
import 'package:anime_list/common/extensions/extensions.dart';
import 'package:anime_list/common/styles/padding.dart';
import 'package:anime_list/common/styles/text_style.dart';
import 'package:anime_list/common/widgets/ios_back_button.dart';
import 'package:anime_list/common/widgets/lengkap.dart';
import 'package:anime_list/common/widgets/open_image.dart';
import 'package:anime_list/core/screens/error_screen.dart';
import 'package:anime_list/core/widgets/loader.dart';
import 'package:anime_list/cubits/language_anime_cubit.dart';
import 'package:anime_list/models/anime_details.dart';
import 'package:anime_list/models/picture.dart';
import 'package:anime_list/views/rekom_anime.dart';
import 'package:anime_list/widgets/info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({
    super.key,
    required this.id,
    });
    final int id;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getAnimeDetailsApi(id: id), 
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return const Loader();
      }

      if (snapshot.data != null) {
        final anime = snapshot.data;
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Top Image
                _buildAnimeImageWidget(
                  imageUrl: anime!.mainPicture.large,
                ),

                //Judul Anime
                Padding(
                  padding: Paddings.defaultPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAnimeTitle(name: anime.title, englishName: anime.alternativeTitles.en,
                      ),

                      const SizedBox(height: 20),
                      //deskripai
                      Lengkap(longText: anime.synopsis,
                      ),

                      const SizedBox(height: 10),

                      //inpo inpo anime wibu nyaa
                      _buildAnimeInpoInpo(
                        anime: anime,
                      ),

                      const SizedBox(height: 20),
                      //backgroundanime
                      anime.background.isNotEmpty ?
                      _buildAnimeBg(background: anime.background,):
                      const SizedBox.shrink(),


                      const SizedBox(height: 20),
                      //galeri
                      _buildGaleri(images: anime.pictures),

                      const SizedBox(height: 20),

                      RekomAnime(animes: anime.relatedAnime.map((relatedAnime) => relatedAnime.node).toList(),
                      label: 'Related Anime',
                      ),

                      const SizedBox(height: 20),

                      RekomAnime(animes: anime.recommendations.map((animeRec) => animeRec.node).toList(),
                      label: 'Recommendations',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return ErrorScreen(error: 
      snapshot.error.toString());
    },
    );
  }

  _buildAnimeImageWidget({
    required String imageUrl,
  }) => Stack(
    children: [
      CachedNetworkImage(imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: 400,
      width: double.infinity,
      ),
      Positioned(
        top: 30,
        left: 20,
        child: Builder(builder: (context){
          return IosBackButton(
            onPressed: Navigator.of(context).pop,
          );
        },),
      )
    ],
  );


  Widget _buildAnimeTitle(
    {
      required String name,
      required String englishName,
    }
  ) => BlocBuilder<AnimeTitleLanguageCubit, bool>(
    builder: (context, state) {
      bool isEnglish = state;
      return Text(
        isEnglish ? englishName: name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      );
    }
  );

  Widget _buildAnimeInpoInpo({
    required AnimeDetails anime,
  }){
    String studios = anime.studios.map((studio) => studio.name).join(', ');
    String genres = anime.genres.map((genre) => genre.name).join(', ');
    String otherNames =
        anime.alternativeTitles.synonyms.map((title) => title).join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InpoText(label: 'Genres: ', info: genres),
        InpoText(label: 'Start date: ', info: anime.startDate),
        InpoText(label: 'End date: ', info: anime.endDate),
        InpoText(label: 'Episodes: ', info: anime.numEpisodes.toString()),
        InpoText(
          label: 'Average Episode Duration: ',
          info: anime.averageEpisodeDuration.toMinute(),
        ),
        InpoText(label: 'Status: ', info: anime.status),
        InpoText(label: 'Rating: ', info: anime.rating),
        InpoText(label: 'Studios: ', info: studios),
        InpoText(label: 'Other Names: ', info: otherNames),
        InpoText(label: 'English Name: ', info: anime.alternativeTitles.en),
        InpoText(label: 'Japanese Name: ', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBg({
    required String background,
  }) {
    return WhieContainer(child: Text(background,style: const TextStyle(
      fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black,
      ),
    ),
    );
  }

  Widget _buildGaleri({
    required List<Picture> images,
  }) {
    return  Column(
      children: [const Text('Image Gallery', style: TextStyles.mediumText,),
      GridView.builder(
        itemCount: images.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 9/16, crossAxisSpacing: 8, mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          final image = images[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OpenImage(imageUrl: image.large,
                ),
                ),
              );
              },
              child: Image.network(
                image.medium,fit: BoxFit.cover,
              ),
            ),
          );
        },
        ),
      ],
    );
  }
}


class WhieContainer extends StatelessWidget {
  const WhieContainer({super.key, required this.child,});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.white54,
      child: Padding(padding: const EdgeInsets.all(16.0),
      child: child),
    );
  }
}