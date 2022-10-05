import 'package:flutter/foundation.dart';
import 'package:wac_task/database_helper/db_helper.dart';
import 'package:wac_task/main.dart';
import 'package:wac_task/models/user_model.dart';
import 'package:wac_task/services/api_services.dart';

class UserDataController extends ChangeNotifier {
  List<UserModel> usersList = [];
  List<UserModel> searchList = [];

  bool isLoading = true;
  bool isSearching = false;

  getAllUsers() async {
    String? value = await storage.read(key: "stored");

    if (value == null) {
      print("API Called");

      usersList = await ApiServices().getAllUsers();
      storage.write(key: "stored", value: "stored");

      usersList.map((e) {
        DataBaseHelper.db.insertUserData(e);
      }).toList();

      isLoading = false;
      notifyListeners();
    } else {
      print("Local Storage Called");
      usersList = await DataBaseHelper.db.getAllUserData();
      isLoading = false;
      notifyListeners();
    }
  }

  search(String data) {
    if (data.isNotEmpty) {
      searchList = [];
      usersList.forEach((item) {
        if (item.email!.toLowerCase().contains(data.toLowerCase()) ||
            item.name!.toLowerCase().contains(data.toLowerCase())) {
          searchList.add(item);
          isSearching = true;
          notifyListeners();
        }
      });
      return;
    } else {
      isSearching = false;
      searchList = [];
      notifyListeners();
    }
  }

  cancelSearch() {
    isSearching = false;
    searchList = [];
    notifyListeners();
  }
}
