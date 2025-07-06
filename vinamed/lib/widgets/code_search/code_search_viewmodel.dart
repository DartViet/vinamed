import 'package:database_models/models/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:ltdmed/goodies/code_search_service.dart';

class CodeSearchViewmodel extends ChangeNotifier {
  // Private constructor
  CodeSearchViewmodel._internal();

  // Static instance
  static final CodeSearchViewmodel _instance = CodeSearchViewmodel._internal();

  // Factory constructor that returns the same instance
  factory CodeSearchViewmodel() => _instance;

  // Getter for the instance
  static CodeSearchViewmodel get instance => _instance;

  String selectedOption = Variables.instance.icd10cm;
  Map<String, String> options = Variables.instance.codeToName;
  String searchQuery = '';
  List<Object> searchResults = [];

  Future<void> submitSearch() async {
    // Implement search logic here
    print('Searching for: $searchQuery in $selectedOption');
    searchResults = await CodeSearchService.instance.searchCodes(searchQuery, selectedOption);
    notifyListeners();
  }

  void clearnSearch() {
    searchQuery = '';
    searchResults = [];
    notifyListeners();
  }
}
