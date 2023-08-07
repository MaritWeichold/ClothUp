import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/image_provider.dart';
import 'outfitcreation_screen.dart';

class OutfitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myImageProvider = Provider.of<MyImageProvider>(context);

    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: myImageProvider.outfits.length + 1,
        itemBuilder: (context, index) {
          if (index < myImageProvider.outfits.length) {
            final outfit = myImageProvider.outfits[index];
            return GestureDetector(
              onTap: () {
              },
              child: Card(
                child: Column(
                  children: [
                    Flexible(
                      child: Image.file(
                        outfit[0].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Flexible(
                      child: Image.file(
                        outfit[1].image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _deleteOutfit(context, myImageProvider, outfit);
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Card(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutfitcreationScreen(),
                    ),
                  );
                },
                child: Text(
                  '+',
                  style: TextStyle(fontSize: 90),
                ),
              ),
            );
          }
        },
      ),
    );
  }

    // Outfit löschen
  void _deleteOutfit(BuildContext context, MyImageProvider myImageProvider, List<ClothingItem> outfit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Outfit löschen'),
          content: Text('Möchtest du dieses Outfit wirklich aus deiner Kollektion löschen?'),
          actions: [
            TextButton(
              onPressed: () {
                myImageProvider.removeOutfit(outfit);
                Navigator.of(context).pop();
              },
              child: Text('Löschen'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Abbrechen'),
            ),
          ],
        );
      },
    );
  }

}
