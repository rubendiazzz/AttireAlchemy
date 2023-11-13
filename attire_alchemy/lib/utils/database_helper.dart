//Database for the app

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:attire_alchemy/models/outfit.dart';

class DatabaseHelper {
  static final _databaseName = "attire_alchemy.db";
  static final _databaseVersion = 1;

  static final table = 'outfit_table';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnDescription = 'description';
  static final columnImage = 'image';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnImage TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(Outfit outfit) async {
    Database db = await instance.database;
    return await db.insert(table, outfit.toMap());
  }

  Future<List<Outfit>> queryAllRows() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> allRows = await db.query(table);
    return allRows.map((row) => Outfit.fromMap(row)).toList();
  }

  Future<int> update(Outfit outfit) async {
    Database db = await instance.database;
    int id = outfit.id!;
    return await db.update(table, outfit.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
import 'package:path_provider/path_provider.dart';
import 'package:attire_alchemy/models/outfit.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'attire_alchemy.db';
  static const _databaseVersion = 1;

  static const _outfitTable = 'outfit';
  static const _columnId = 'id';
  static const _columnTop = 'top';
  static const _columnBottom = 'bottom';
  static const _columnShoes = 'shoes';
  static const _columnSeason = 'season';
  static const _columnOccasion = 'occasion';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_outfitTable (
        $_columnId INTEGER PRIMARY KEY,
        $_columnTop TEXT NOT NULL,
        $_columnBottom TEXT NOT NULL,
        $_columnShoes TEXT NOT NULL,
        $_columnSeason TEXT NOT NULL,
        $_columnOccasion TEXT NOT NULL
      );
    ''');
  }

  Future<int> insertOutfit(Outfit outfit) async {
    final db = await instance.database;
    return await db!.insert(_outfitTable, outfit.toMap());
  }

  Future<List<Outfit>> getOutfits() async {
    final db = await instance.database;
    final maps = await db!.query(_outfitTable);
    return List.generate(maps.length, (i) {
      return Outfit(
        id: maps[i][_columnId],
        top: maps[i][_columnTop],
        bottom: maps[i][_columnBottom],
        shoes: maps[i][_columnShoes],
        season: maps[i][_columnSeason],
        occasion: maps[i][_columnOccasion],
      );
    });
  }
}
