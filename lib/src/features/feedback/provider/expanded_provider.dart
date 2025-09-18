import 'package:flutter/material.dart';

class ExpandProvider with ChangeNotifier {
  List<bool> isExpandedList = [];

  ExpandProvider(int itemCount) {
    // Sab items ko by default collapsed rakhein
    isExpandedList = List<bool>.filled(itemCount, false);
  }

  void toggleExpand(int index) {
    if (isExpandedList[index]) {
      isExpandedList[index] = false;
    } else {
      // Sab items ko collapse kar dein
      for (int i = 0; i < isExpandedList.length; i++) {
        isExpandedList[i] = false;
      }
      // Sirf clicked item ko expand kar dein
      isExpandedList[index] = true;
    }
    notifyListeners();
  }
}
