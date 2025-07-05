import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ltdmed/l10n/language_service.dart';
import 'package:ltdmed/l10n/langvar.dart';
import 'package:ltdmed/models/base_model.dart';

class AppbarViewmodel with ChangeNotifier implements BaseModel {
  static AppbarViewmodel? _instance;
  static AppbarViewmodel get instance {
    _instance ??= AppbarViewmodel();
    return _instance!;
  }

  Future<void> init() async {
    if (langs.isNotEmpty) {
      return;
    }
    // Simulate a network call
    langs = await LangUtility.getAllLanguages();
    title = await LangUtility.getString(LangVar.title, currentLang);
    await LanguageService.instance.changeLang(currentLang);
    _instance = this;
    notifyListeners();
  }

  @override
  Future<void> changeLang(String lang) async {
    currentLang = lang;
    title = await LangUtility.getString(LangVar.title, currentLang);
    await LanguageService.instance.changeLang(lang);
    notifyListeners();
  }

  String currentLang = LangVar.vi;
  List<String> langs = [];
  String title = "";
}
