import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 168, 199, 212),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 37, 46, 62),
          title:  Text('Obscura',
          style:TextStyle(
            color: Colors.white,
          ),
          ),
          leading: Icon(Icons.menu,
          color: Colors.white,
          size: 28,
          ),
          actions: [IconButton(onPressed: () {} , icon: Icon(Icons.info),color: Colors.white,)],
        ),
        body: Column(
          children: [
            

          ],
        ),
    ),
    );
  }
}
