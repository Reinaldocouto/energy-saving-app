import 'package:flutter/material.dart';
import 'package:gs_2sem/screens/HomeScreen.dart';
import 'package:gs_2sem/screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Energy Saving',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // Define a tela inicial
    );
  }
}
