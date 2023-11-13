import 'package:flutter/material.dart';

void main() {
  runApp(const AttireAlchemy());
}

class AttireAlchemy extends StatelessWidget {
  const AttireAlchemy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AttireAlchemy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to AttireAlchemy!'),
      ),
    );
  }
}
