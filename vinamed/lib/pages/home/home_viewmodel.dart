import 'package:flutter/material.dart';
import 'package:ltdmed/models/base_model.dart';

class HomeViewModel with ChangeNotifier implements BaseModel {
  static HomeViewModel? _instance;
  static HomeViewModel get instance {
    _instance ??= HomeViewModel();
    return _instance!;
  }

  Future<void> init() async {
    // Simulate a network call
    notifyListeners();
  }

  @override
  Future<void> changeLang(String lang) async {
    notifyListeners();
  }
}
