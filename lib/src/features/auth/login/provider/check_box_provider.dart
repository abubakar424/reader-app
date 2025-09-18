import 'package:flutter/material.dart';

class CheckBoxProvider extends ChangeNotifier{

  //login in check box provider
  bool _isCheck = true;
  bool get isCheck => _isCheck;

  changeValue(){
    _isCheck =! _isCheck;
    notifyListeners();
  }

  //login and signup in visibility icon provider
  bool _isVisible = true;
  bool get isVisible => _isVisible;
  isVisibleChangeValue(){
    _isVisible =! _isVisible;
    notifyListeners();
  }

  //login and sign up in textFormFiled provider use the focus and unFocus
  bool _isFocused = false;
  bool _hasText = false;
  bool get isFocused => _isFocused || _hasText;

  onFocusChange(bool focus){
    _isFocused = focus;
    notifyListeners();
  }

  onTextChange(String value){
    _hasText = value.isNotEmpty;
    notifyListeners();
  }
}