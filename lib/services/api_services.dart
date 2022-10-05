import 'dart:convert';

import 'package:wac_task/constants/apis.dart';
import 'package:wac_task/database_helper/db_helper.dart';
import 'package:wac_task/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<UserModel>> getAllUsers() async {
    try {
      DataBaseHelper.db.database;
      var res = await http.get(Uri.parse(Apis.BASE_URL));
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
