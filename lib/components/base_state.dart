import 'package:flutter/cupertino.dart';

class BaseState extends ChangeNotifier {
  bool isLoading = false;
  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
