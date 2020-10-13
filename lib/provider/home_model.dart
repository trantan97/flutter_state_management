import 'package:flutter/foundation.dart';

class HomeModel extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}
