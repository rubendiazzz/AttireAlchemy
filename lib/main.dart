import 'package:flutter/material.dart';
import 'package:ai_outfit_creator/screens/home_screen.dart'; // Importa tus pantallas aquí

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi App Flutter', // Nombre de tu aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema de la aplicación
      ),
      home: HomeScreen(), // Pantalla de inicio
    );
  }
}
