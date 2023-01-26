import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = 'notes.db';
  static const _dbVersion = 1;
  static const noteTable = 'note_table';
  static const id = 'id';
  static const title = 'title';
  static const content = 'content';
  static const created = 'created';
  static const last_updated = 'lastUpdated';
  static const color = 'color';

  //Making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database databases;

  Future<Database> get database async {
    if (databases != null) return databases;

    databases = await _initiateDatabase();
    return databases;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute('''
        CREATE TABLE $noteTable (
        $id INTEGER PRIMARY KEY,
        $title TEXT NOT NULL,
        $content TEXT NOT NULL,
        $color TEXT,
        $created TEXT NOT NULL,
        $last_updated TEXT NOT NULL)
      ''');
    print('Database Created');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(noteTable, row, nullColumnHack: id);
  }

  Future<List<Map<String, dynamic>>> queryNote(int noteId) async {
    Database db = await instance.database;
    return await db.query(noteTable,
    columns: [
      id,
      title,
      content,
      color,
      created,
      last_updated],
    where: '$id = ?',
    whereArgs: [noteId]);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(noteTable,
      columns: [
        id,
        title,
        content,
        color,
        created,
        last_updated],
      orderBy: '$last_updated DESC'
    );
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int currentId = row['id'];
    return await db.update(noteTable, row,
        where: '$id = ?', whereArgs: [currentId]);
  }

  Future<int> delete(List ids) async {
    Database db = await instance.database;
    return await db.delete(noteTable, where: '$id = ?', whereArgs: ids);
  }

  Future<int> isDatabaseNull() async{
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $noteTable'));
  }
}
