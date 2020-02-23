import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.red,
  Colors.grey,
];
class Global {
  // 插件
  static SharedPreferences _prefs;

  // 用户信息
  static Profile profile = Profile();

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
  }
  // 持久化Profile信息
  static saveProfile() =>
    _prefs.setString("profile", jsonEncode(profile.toJson()));
} 