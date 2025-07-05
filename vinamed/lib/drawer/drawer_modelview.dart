import 'package:flutter/material.dart';
import 'package:ltdmed/models/base_model.dart';

class DrawerModelView with ChangeNotifier implements BaseModel {
  static DrawerModelView? _instance;
  static DrawerModelView get instance {
    _instance ??= DrawerModelView();
    return _instance!;
  }

  Future<void> init() async {
    _instance = this;
    notifyListeners();
  }

  @override
  Future<void> changeLang(String lang) async {
    notifyListeners();
  }
}
