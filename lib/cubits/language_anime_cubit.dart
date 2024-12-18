import 'package:anime_list/databasehelp/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef IsEnglish = bool;

class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
  AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }

  bool get isEnglish => state;

  // awal
  Future _fetchAnimeTitleLanguage() async {
    final isEnglish = await DatabaseHelper.instance.isEnglish;
    emit(isEnglish);
  }

  // ubah Anime Title Language
  Future changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish);
  }
}