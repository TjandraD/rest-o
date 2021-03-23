import '../model/restaurant_favorites.dart';
import '../model/restaurant_details.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  static const String _tbFavorites = 'tb_favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/rest-o.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tbFavorites (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating REAL
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) _database = await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantDetails restaurant) async {
    RestaurantFavorites data = RestaurantFavorites.fromRestaurant(restaurant);
    final db = await database;
    await db.insert(_tbFavorites, data.toJson());
  }

  Future<List<RestaurantFavorites>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tbFavorites);

    return results.map((res) => RestaurantFavorites.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tbFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tbFavorites,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
