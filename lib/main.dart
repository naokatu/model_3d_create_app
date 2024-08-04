import 'package:flutter/material.dart';
import './header.dart';
import './myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D-create-app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        appBar: Header(title: 'ホーム'),
        drawer: Drawer(),
        body: MyHomePage(),
      )
    );
  }
}


