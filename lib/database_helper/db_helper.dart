import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wac_task/models/user_model.dart';

class DataBaseHelper {
  static Database? _database;
  static final DataBaseHelper db = DataBaseHelper._();
  DataBaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initUserDataBase();
    return _database!;
  }

  initUserDataBase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'user_data.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE UserData('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'username TEXT,'
          'email TEXT,'
          'profile_image TEXT,'
          'address TEXT,'
          'phone TEXT,'
          'website TEXT,'
          'company TEXT'
          ')');
    });
  }

  insertUserData(UserModel questions) async {
    final db = await database;
    final res = await db.insert('UserData', questions.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<UserModel>> getAllUserData() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM UserData");
    List<UserModel> list = res.isNotEmpty
        ? res.map((Map map) {
            Map<String, dynamic> company = {};
            Map<String, dynamic> address = {};
            if (map['address'] != null) {
              address = json.decode(map['address']);
            }
            if (map['company'] != null) {
              company = json.decode(map['company']);
            }

            return UserModel(
              id: map['id'],
              name: map['name'],
              email: map['email'],
              phone: map['phone'],
              profileImage: map['profile_image'],
              username: map['username'],
              website: map['website'],
              address: Address.fromJson(address),
              company: Company.fromJson(company),
            );
          }).toList()
        : [];
    return list;
  }
}
