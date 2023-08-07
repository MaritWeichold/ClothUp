import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/image_provider.dart';

class SuitcasesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final mySecondImageProvider = Provider.of<MySecondImageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Koffer'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                final picker = ImagePicker();
                final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  // Hier Logik zum Hinzufügen des ausgewählten Bildes als neuen Koffer
                }
              },
              child: Text('Wähle ein Bild aus, was du in deinen Koffer packen möchtest.'),
            ),
          ),
        ],
        // children: [
        //   Expanded(
        //     child: GridView.builder(
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         mainAxisSpacing: 8,
        //         crossAxisSpacing: 8,
        //       ),
        //       itemCount: mySecondImageProvider.images.length,
        //       itemBuilder: (context, index) {
        //         final item = mySecondImageProvider.images[index];

        //         return GestureDetector(
        //           onTap: () {
        //             _editDescription(context, mySecondImageProvider, item);
        //           },
        //           child: Card(
        //             child: Column(
        //               children: [
        //                 Flexible(
        //                   child: Image.file(
        //                     item.image,
        //                     fit: BoxFit.contain,
        //                   ),
        //                 ),
        //                 Text(item.description),
        //                 ElevatedButton(
        //                   onPressed: () {
        //                     _deleteImage(context, mySecondImageProvider, item);
        //                   },
        //                   child: Icon(Icons.delete),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => SuitcasecreationScreen(),
        //           ),
        //         );
        //       },
        //       child: Text('Koffer hinzufügen'),
        //     ),
        //   ),
        // ],
      ),
    );
  }

  // Beschreibung bearbeiten
  void _editDescription(BuildContext context, MySecondImageProvider mySecondImageProvider, ClothingItem item) {
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
                mySecondImageProvider.updateDescription(item, descriptionController.text);
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
  void _deleteImage(BuildContext context, MySecondImageProvider mySecondImageProvider, ClothingItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bild löschen'),
          content: Text('Möchtest du dieses Bild wirklich löschen?'),
          actions: [
            TextButton(
              onPressed: () {
                mySecondImageProvider.removeImage(item);
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
