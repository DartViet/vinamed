import 'package:flutter/material.dart';

class UserInfoModelView extends ChangeNotifier {
  static UserInfoModelView? _instance;
  static UserInfoModelView get instance {
    _instance ??= UserInfoModelView();
    return _instance!;
  }

  Future<void> init() async {
    _instance = this;
  }
}
