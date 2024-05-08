import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProfileImageDatabase {
  static final ProfileImageDatabase _instance = ProfileImageDatabase._internal();

  factory ProfileImageDatabase() => _instance;

  ProfileImageDatabase._internal();

  static late Database _database;

  Future<Database> get database async {
    if (_database.isOpen) return _database; // Check if database is already open
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'profile_image.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE ProfileImage (
        id INTEGER PRIMARY KEY,
        image BLOB
      )
    ''');
  }

  Future<void> insertImage(File imageFile) async {
    final db = await database;
    await db.insert(
      'ProfileImage',
      {'image': imageFile.readAsBytesSync()},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<File> getImage() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('ProfileImage', limit: 1);
    if (result.isEmpty) throw Exception('No image found in database');
    return File.fromRawPath(result.first['image']);
  }
}
