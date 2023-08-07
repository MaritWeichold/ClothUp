import 'package:flutter/material.dart';
import 'image_provider_base.dart';

class OutfitImageProvider extends ImageProviderBase {
  List<List<ClothingItem>> _outfits = [];

  List<List<ClothingItem>> get outfits => _outfits;

  void addOutfit(List<ClothingItem> outfit) {
    _outfits.add(outfit);
    notifyListeners();
  }

  void removeOutfit(List<ClothingItem> outfit) {
    _outfits.remove(outfit);
    notifyListeners();
  }
}
