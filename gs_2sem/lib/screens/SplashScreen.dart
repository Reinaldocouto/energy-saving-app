import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gs_2sem/screens/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Aguarda 5 segundos e depois navega para a HomeScreen
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1F44),
      body: Center(
        child: Image.asset(
          'lib/images/logo.jpeg', // Caminho para a imagem
          fit: BoxFit.contain, // A imagem ocupa toda a tela
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
