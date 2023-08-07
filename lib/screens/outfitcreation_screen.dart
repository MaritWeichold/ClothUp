import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/image_provider.dart';

class OutfitcreationScreen extends StatefulWidget {
  @override
  _OutfitcreationScreenState createState() => _OutfitcreationScreenState();
}

class _OutfitcreationScreenState extends State<OutfitcreationScreen> {
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final myImageProvider = Provider.of<MyImageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Outfit erstellen'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: myImageProvider.images.length,
        itemBuilder: (context, index) {
          final item = myImageProvider.images[index];

          return GestureDetector(
            onTap: () {
              _toggleImageSelection(item.image);
            },
            child: Card(
              color: selectedImages.contains(item.image) ? Colors.grey : Colors.white,
              child: Column(
                children: [
                  Flexible(
                    child: Image.file(
                      item.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(item.description),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveOutfit(context, myImageProvider, selectedImages);
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void _toggleImageSelection(File image) {
    setState(() {
      if (selectedImages.contains(image)) {
        selectedImages.remove(image);
      } else {
        selectedImages.add(image);
      }
    });
  }

  // Outfit speichern
  void _saveOutfit(BuildContext context, MyImageProvider myImageProvider, List<File> selectedImages) {
    if (selectedImages.length == 2) {
      List<ClothingItem> outfitItems = [
        ClothingItem(image: selectedImages[0]),
        ClothingItem(image: selectedImages[1]),
      ];
      myImageProvider.addOutfit(outfitItems);
      Navigator.of(context).pop();
    }
  }
}
