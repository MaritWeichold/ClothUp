import 'dart:io';

import 'package:flutter/material.dart';

class ClothingItem {
  final File image;
  String description;
  bool isLiked;

  ClothingItem({required this.image, this.description = '', this.isLiked = false});
}


class MyImageProvider extends ChangeNotifier {
  List<ClothingItem> _images = [];
  List<List<ClothingItem>> _outfits = [];
  List<List<ClothingItem>> _suitcases = [];

  // getter
  List<ClothingItem> get images => _images;
  List<List<ClothingItem>> get outfits => _outfits;
  List<List<ClothingItem>> get suitcases => _suitcases;

  void addImage(ClothingItem item) {
    _images.add(item);
    notifyListeners();
  }

  void addOutfit(List<ClothingItem> outfit) {
    _outfits.add(outfit);
    notifyListeners();
  }

  void addSuitcase(List<ClothingItem> suitcase) {
    _suitcases.add(suitcase);
    notifyListeners();
  }

  void removeOutfit(List<ClothingItem> outfit) {
    _outfits.remove(outfit);
    notifyListeners();
  }

  void removeSuitcase(List<ClothingItem> suitcase) {
    _suitcases.remove(suitcase);
    notifyListeners();
  }

  void removeImage(ClothingItem item) {
    _images.remove(item);
    notifyListeners();
  }

  void updateDescription(ClothingItem item, String newDescription) {
    final index = _images.indexOf(item);
    if (index != -1) {
      _images[index].description = newDescription;
      notifyListeners();
    }
  }
}

class MySecondImageProvider extends ChangeNotifier {
  List<ClothingItem> _images = [];
  List<List<ClothingItem>> _suitcases = [];

  // getter
  List<ClothingItem> get images => _images;
  List<List<ClothingItem>> get suitcases => _suitcases;

  void addImage(ClothingItem item) {
    _images.add(item);
    notifyListeners();
  }

  void addSuitcase(List<ClothingItem> suitcase) {
    _suitcases.add(suitcase);
    notifyListeners();
  }

  void removeSuitcase(List<ClothingItem> suitcase) {
    _suitcases.remove(suitcase);
    notifyListeners();
  }

  void removeImage(ClothingItem item) {
    _images.remove(item);
    notifyListeners();
  }

  void updateDescription(ClothingItem item, String newDescription) {
    final index = _images.indexOf(item);
    if (index != -1) {
      _images[index].description = newDescription;
      notifyListeners();
    }
  }
}
