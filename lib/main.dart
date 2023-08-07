import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_provider.dart';
import 'screens/closet_screen.dart';
import 'screens/outfits_screen.dart';
import 'screens/suitcases_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyImageProvider()),
        ChangeNotifierProvider(create: (context) => MySecondImageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(197, 112, 89, 1)),
        useMaterial3: true,
      ),
      home: const Closet(),
      routes: {
        '/closet': (context) => ClosetScreen(),
        '/suitcases': (context) => SuitcasesScreen(),
        '/outfits': (context) => OutfitsScreen(),
      },
    );
  }
}

class Closet extends StatefulWidget {
  const Closet({Key? key}) : super(key: key);

  @override
  State<Closet> createState() => _ClosetState();
}

class _ClosetState extends State<Closet> {
  int currentIndex = 0;
  
  List<Widget> screens = [
    ClosetScreen(),
    SuitcasesScreen(),
    OutfitsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ClotheUp",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        // leading: IconButton(
        //   icon: Icon(Icons.delete),
        //   onPressed: null,
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.door_sliding_sharp), label: "Closet"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Suitcases"),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_people), label: "Outfits"),
          ],
        ),
      body: screens.elementAt(currentIndex),
    );
  }
}
