import 'package:anime_list/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DatabaseHelper {
  //jadi kelas tunggal
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static SharedPreferences ? _database;

  // get database

  Future<SharedPreferences> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //inisialisasi database

  Future<SharedPreferences>  _initDatabase() async {
    _database = await SharedPreferences.getInstance();
    return _database!;
  }

  // mode tema

  Future<bool> get isDarkMode async {
    final db = await instance.database;
    return db.getBool(Constants.isDarkMode) ?? false;
  }

  Future<bool> setDarkMode(bool isDark) async {
    final db = await instance.database;
    return await db.setBool(Constants.isDarkMode, isDark);
  }

  //penyetel bahasa

  Future<bool> get isEnglish async {
    final db = await instance.database;
    return db.getBool(Constants.isEnglish) ?? false;
  }

  Future<bool> setIsEnglish(bool isEnglish) async {
    final db = await instance.database;
    return await db.setBool(Constants.isEnglish, isEnglish);
  }
}