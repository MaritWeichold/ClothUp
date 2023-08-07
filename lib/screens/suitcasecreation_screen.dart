import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/image_provider.dart';

class SuitcasecreationScreen extends StatefulWidget {
  @override
  _SuitcasecreationScreenState createState() => _SuitcasecreationScreenState();
}

class _SuitcasecreationScreenState extends State<SuitcasecreationScreen> {
  List<File> selectedClothes = [];

  @override
  Widget build(BuildContext context) {
    final mySecondImageProvider = Provider.of<MySecondImageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Koffer zusammenstellen'),
      ),
body: GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  ),
  itemCount: mySecondImageProvider.images.length,
  itemBuilder: (context, index) {
    final item = mySecondImageProvider.images[index];

    return GestureDetector(
      onTap: () {
        _toggleClothesSelection(item);
      },
      child: Card(
        color: selectedClothes.contains(item) ? Colors.grey : Colors.white,
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
          _saveSuitcase(context, mySecondImageProvider, selectedClothes);
        },
        child: Icon(Icons.check),
      ),
    );
  }

  void _toggleClothesSelection(ClothingItem item) {
    setState(() {
      final image = item.image;
      if (selectedClothes.contains(image)) {
        selectedClothes.remove(image);
      } else {
        selectedClothes.add(image);
      }
    });
  }

  // Koffer speichern
  void _saveSuitcase(BuildContext context, MySecondImageProvider mySecondImageProvider, List<File> selectedClothes) {
    if (selectedClothes.length == 2) {
      List<ClothingItem> suitcaseItems = [
        ClothingItem(image: selectedClothes[0]),
        ClothingItem(image: selectedClothes[1]),
      ];
      mySecondImageProvider.addSuitcase(suitcaseItems);
      Navigator.of(context).pop();
    }
  }
}
