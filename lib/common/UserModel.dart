import 'package:flutter/material.dart';
import '../models/index.dart';
import 'Global.dart';

class UserModel extends ChangeNotifier {
  Profile get _profile => Global.profile; // 需要持久化存储的用户数据
  User get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      Global.saveProfile();
      notifyListeners();
    }
  }
}