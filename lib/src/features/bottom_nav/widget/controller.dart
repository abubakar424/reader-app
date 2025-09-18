// // global_tab_controller.dart
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// // Define the global controller here
// final PersistentTabController globalPersistentTabController = PersistentTabController(initialIndex: 0);

// global_tab_controller.dart
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// Global controller
final PersistentTabController globalPersistentTabController =
    PersistentTabController(initialIndex: 0);

class btmBarProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
