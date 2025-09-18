import 'dart:io';
import 'package:flutter/material.dart';

class ImageProviderNotifier extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _bio = '';
  File? _selectedImage;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get bio => _bio;
  File? get selectedImage => _selectedImage;

  void updateFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  void updateBio(String bio) {
    _bio = bio;
    notifyListeners();
  }

  void updateImage(File? newImage) {
    _selectedImage = newImage;

    notifyListeners();
  }
}
