import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class  PrefsService{

  static storeUserList(List<User> userList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userListString =
    userList.map((user) => jsonEncode(user.toMap())).toList();
    await prefs.setStringList('user_list', userListString);
  }

  static Future<List<User>> loadUserList() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userListString = prefs.getStringList("user_list");
    if (userListString == null || userListString.isEmpty) return [];

    List<User> userList = userListString
        .map((userString) => User.fromMap(json.decode(userString)))
        .toList();
    return userList;
  }

  static Future<bool> removeUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("user_list");
  }


}