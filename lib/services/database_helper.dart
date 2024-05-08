import 'dart:io';
import 'package:path/path.dart';
import 'package:profile_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String databaseName = "auth.db";

  //Tables
  String user = '''
   CREATE TABLE users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
   )
   ''';

  String profileImage = '''
   CREATE TABLE ProfileImage (
   id INTEGER PRIMARY KEY,
   image BLOB
   )
   ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
      await db.execute(profileImage);
    });
  }

  Future<bool> authenticate(Users usr) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${usr.usrName}' AND usrPassword = '${usr.password}' ");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> createUser(Users usr) async {
    final Database db = await initDB();
    return db.insert("users", usr.toMap());
  }

  Future<Users?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("users", where: "usrName = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }

  Future<void> updateUser(Users usr) async {
    final Database db = await initDB();
    await db.update(
      'users',
      usr.toMap(),
      where: 'usrId = ?',
      whereArgs: [usr.usrId],
    );
  }

  Future<void> insertProfileImage(File imageFile) async {
    final db = await initDB();
    await db.insert(
      'ProfileImage',
      {'image': imageFile.readAsBytesSync()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<File> getProfileImage() async {
    final db = await initDB();
    List<Map> result = await db.query('ProfileImage', limit: 1);
    if (result.isEmpty) return File(''); // Return empty file if no image found
    return File.fromRawPath(result.first['image']);
  }
}
