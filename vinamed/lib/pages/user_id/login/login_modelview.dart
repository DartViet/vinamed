import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar_viewmodel.dart';
import 'package:ltdmed/models/base_model.dart';

class LoginModelView with ChangeNotifier implements BaseModel {
  static LoginModelView? _instance;

  static LoginModelView get instance {
    _instance ??= LoginModelView();
    return _instance!;
  }

  Future<void> init() async {
    String currentLang = AppbarViewmodel.instance.currentLang; // Default language
    await _changeLang(currentLang);

    _instance = this;
  }

  @override
  Future<void> changeLang(String lang) async {
    await _changeLang(lang);
  }

  Future<void> _changeLang(String lang) async {
    notifyListeners();
  }
}
