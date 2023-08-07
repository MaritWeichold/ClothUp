import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SuitcasesScreen extends StatefulWidget {
  @override
  _SuitcasesScreenState createState() => _SuitcasesScreenState();
}

class _SuitcasesScreenState extends State<SuitcasesScreen> {
  List<Suitcase> _suitcases = [];

  @override
  Widget build(BuildContext context) {
    // final mySecondImageProvider = Provider.of<MySecondImageProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addSuitcase,
              child: Text('Koffer hinzufügen'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _suitcases.length,
              itemBuilder: (context, index) {
                return _buildSuitcaseCard(_suitcases[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
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


  // // Beschreibung bearbeiten
  // void _editDescription(BuildContext context, MySecondImageProvider mySecondImageProvider, ClothingItem item) {
  //   TextEditingController descriptionController = TextEditingController(text: item.description);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Beschreibung bearbeiten'),
  //         content: TextFormField(
  //           controller: descriptionController,
  //           maxLines: null,
  //           keyboardType: TextInputType.multiline,
  //           decoration: InputDecoration(
  //             labelText: 'Beschreibung',
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               mySecondImageProvider.updateDescription(item, descriptionController.text);
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Speichern'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Abbrechen'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // // Kleidungsstück löschen
  // void _deleteImage(BuildContext context, MySecondImageProvider mySecondImageProvider, ClothingItem item) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Bild löschen'),
  //         content: Text('Möchtest du dieses Bild wirklich löschen?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               mySecondImageProvider.removeImage(item);
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Löschen'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Abbrechen'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  
  Widget _buildSuitcaseCard(Suitcase suitcase) {
    return Card(
      child: Column(
        children: [
          if (suitcase.images.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: suitcase.images.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    suitcase.images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              suitcase.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: () => _editSuitcase(context, suitcase),
            child: Text('Koffer bearbeiten'),
          ),
          ElevatedButton(
            onPressed: () => _addImageToSuitcase(context, suitcase),
            child: Text('Bild hinzufügen'),
          ),
        ],
      ),
    );
  }

  void _addSuitcase() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _showSuitcaseNameDialog(context, [File(pickedImage.path)]);
    }
  }


  void _showSuitcaseNameDialog(BuildContext context, List<File> images) {
    String _suitcaseName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Koffer hinzufügen'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _suitcaseName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Wo geht die Reise hin?',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _suitcases.add(Suitcase(name: _suitcaseName, images: images));
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Speichern'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _editSuitcase(BuildContext context, Suitcase suitcase) {
    String _editedName = suitcase.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Koffer bearbeiten'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _editedName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Koffername',
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(text: _editedName),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    suitcase.name = _editedName;
                  });
                  Navigator.of(context).pop();
                },
                child: Text('Speichern'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addImageToSuitcase(BuildContext context, Suitcase suitcase) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        suitcase.images.add(File(pickedImage.path));
      });
    }
  }
}

class Suitcase {
  String name;
  List<File> images;

  Suitcase({required this.name, List<File>? images})
      : images = images ?? [];
}