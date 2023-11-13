import 'package:flutter/material.dart';
import 'package:attire_alchemy/screens/home_screen.dart';
import 'package:attire_alchemy/screens/outfit_generator_screen.dart';

void main() {
  runApp(const AttireAlchemy());
}

class AttireAlchemy extends StatelessWidget {
  const AttireAlchemy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AttireAlchemy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/outfit-generator': (context) => const OutfitGeneratorScreen(),
      },
    );
  }
}
