import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kaalan/models/bookFromLibraryModel.dart';
import 'package:kaalan/models/searchQueryModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseManager {
  DatabaseManager._();

  static final DatabaseManager instance = DatabaseManager._();
  static Database? _database;

  factory DatabaseManager() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      return await databaseFactoryFfiWeb.openDatabase(
        "kaalan.db",
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            db.execute('''
              CREATE TABLE IF NOT EXISTS utilisateurs (
                id INTEGER PRIMARY KEY,
                emailAddress TEXT,
                phone TEXT,
                username TEXT,
                firstname TEXT,
                role TEXT,
                lastname TEXT,
                password TEXT
              )
            ''');

            db.execute('''
              CREATE TABLE IF NOT EXISTS searchqueries (
                id INTEGER PRIMARY KEY,
                query TEXT 
              )
            ''');
            db.execute('''
            CREATE TABLE IF NOT EXISTS mylibrary (
              bookId INTEGER PRIMARY KEY,
              progress INTEGER,
              isFinish INTEGER
               
            )
          ''');
          },
        ),
      );
    } else {
      return await openDatabase(
        join(await getDatabasesPath(), 'kaalan.db'),
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE IF NOT EXISTS utilisateurs (
              id INTEGER PRIMARY KEY,
              emailAddress TEXT,
              phone TEXT,
              username TEXT,
              firstname TEXT,
              role TEXT,
              lastname TEXT,
              password TEXT
            )
          ''');
          db.execute('''
              CREATE TABLE IF NOT EXISTS searchqueries (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                query TEXT UNIQUE
              )
            ''');
          db.execute('''
            CREATE TABLE IF NOT EXISTS mylibrary (
              bookId INTEGER PRIMARY KEY,
              progress INTEGER,
              isFinish INTEGER
               
            )
          ''');
        },
        version: 1,
      );
    }
  }

//user functions
  Future<UserModel?> getLoggedUser() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('utilisateurs');

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> addUser(UserModel user) async {
    final Database db = await database;
    return await db.insert(
      'utilisateurs',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateUser(UserModel user) async {
    final Database db = await database;
    await db.update("utilisateurs", user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  void deleteUser(int id) async {
    final Database db = await database;
    db.delete("utilisateurs", where: "id = ?", whereArgs: [id]);
  }

//searchQueries functions
  Future<List<SearchQueryModel>> getQueries() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('searchqueries');

    if (maps.isNotEmpty) {
      return maps.map((query) => SearchQueryModel.fromMap(query)).toList();
    } else {
      return [];
    }
  }

  Future<int> addQuery(SearchQueryModel query) async {
    final Database db = await database;
    return await db.insert(
      'searchqueries',
      query.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateQuery(SearchQueryModel query) async {
    final Database db = await database;
    await db.update("searchqueries", query.toMap(),
        where: "id = ?", whereArgs: [query.id]);
  }

  Future<int> deleteQuery(int id) async {
    final Database db = await database;
    return await db.delete("searchqueries", where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllQueries() async {
    final Database db = await database;
    await db.delete('searchqueries');
  }

  Future<List<BookFromLibraryModel>> getFinishedBooks() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('mylibrary', where: "isFinish = ?", whereArgs: [1]);

    if (maps.isNotEmpty) {
      return maps.map((book) => BookFromLibraryModel.fromMap(book)).toList();
    } else {
      return [];
    }
  }

  Future<BookFromLibraryModel?> getBookProgress(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('mylibrary', where: "bookId = ?", whereArgs: [id]);

    if (maps.isNotEmpty) {
      return BookFromLibraryModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteBookProgress(int id) async {
    final Database db = await database;
    return await db.delete("mylibrary", where: "bookId = ?", whereArgs: [id]);
  }

  Future<int> addBookProgress(BookFromLibraryModel book) async {
    final Database db = await database;
    return await db.insert(
      'mylibrary',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateBookProgress(BookFromLibraryModel book) async {
    final Database db = await database;
    await db.update("mylibrary", book.toMap(),
        where: "bookId = ?", whereArgs: [book.bookId]);
  }

  //Other functions

  Future<void> clearDatabase() async {
    final Database db = await database;
    await db.delete('utilisateurs');
    await db.delete('searchqueries');
    await db.delete('mylibrary');
    print(
        "========================✅✅✅BASE DE DONNEES EN LOCAL NETTOYEE================================");
  }

  Future<void> deleteDb() async {
    if (kIsWeb) {
      try {
        // Supprimer la base de données en utilisant le service worker

        print("Base de données supprimée avec succès sur le web");
      } catch (e) {
        print(
            "Erreur lors de la suppression de la base de données sur le web: $e");
      }
    } else {
      // Utiliser la méthode générique pour la suppression de la base de données sur les autres plateformes
      final databasePaths = await getDatabasesPath();
      final path = join(databasePaths, 'kaalan.db');
      await deleteDatabase(path);
    }
  }
}
