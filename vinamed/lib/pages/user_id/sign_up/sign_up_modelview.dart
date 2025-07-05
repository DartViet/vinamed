import 'package:flutter/material.dart';
import 'package:ltdmed/appbar/appbar_viewmodel.dart';
import 'package:ltdmed/models/base_model.dart';

class SignUpModelview extends ChangeNotifier implements BaseModel {
  static SignUpModelview? _instance;
  static SignUpModelview get instance {
    _instance ??= SignUpModelview();
    return _instance!;
  }

  Future<void> init() async {
    String currentLang = AppbarViewmodel.instance.currentLang;
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
