import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '/image_provider.dart';

class ClosetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myImageProvider = Provider.of<MyImageProvider>(context);
    final mySecondImageProvider = Provider.of<MySecondImageProvider>(context);


    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: myImageProvider.images.length + 1,
        itemBuilder: (context, index) {
          if (index < myImageProvider.images.length) {
            final item = myImageProvider.images[index];
            return GestureDetector(
              onTap: () {
                _editDescription(context, myImageProvider, item);
              },
              child: Card(
                child: Column(
                  children: [
                    Flexible(
                      child: Image.file(
                        item.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(item.description),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deleteImage(context, myImageProvider, item);
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Card(
              child: TextButton(
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    final imageFile = File(pickedImage.path);
                    myImageProvider.addImage(ClothingItem(image: imageFile));
                    mySecondImageProvider.addImage(ClothingItem(image: imageFile));
                  }
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

  // Beschreibung bearbeiten
  void _editDescription(BuildContext context, MyImageProvider myImageProvider, ClothingItem item) {
    TextEditingController descriptionController = TextEditingController(text: item.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Beschreibung bearbeiten'),
          content: TextFormField(
            controller: descriptionController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              labelText: 'Beschreibung',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                myImageProvider.updateDescription(item, descriptionController.text);
                Navigator.of(context).pop();
              },
              child: Text('Speichern'),
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

  // Kleidungsstück löschen
  void _deleteImage(BuildContext context, MyImageProvider myImageProvider, ClothingItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kleidungsstück löschen'),
          content: Text('Möchtest du dieses Kledungsstück wirklich aus deinem Kleiderschrank löschen?'),
          actions: [
            TextButton(
              onPressed: () {
                myImageProvider.removeImage(item);
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

