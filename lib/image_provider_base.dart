import 'package:flutter/material.dart';

class ClothingItem {
  final String imagePath;
  String description;
  bool isLiked;

  ClothingItem({required this.imagePath, this.description = '', this.isLiked = false});
}

class ImageProviderBase extends ChangeNotifier {
  List<ClothingItem> _images = [];

  List<ClothingItem> get images => _images;

  void addImage(ClothingItem item) {
    _images.add(item);
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
