import 'package:flutter/material.dart';

class SelectedCategoryProvider with ChangeNotifier {
  String _selectedID = '';

  String get selectedID => _selectedID;

  void setSelectedID(String id) {
    _selectedID = id;
    notifyListeners();
  }
}
