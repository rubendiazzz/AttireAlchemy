// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class OutfitGeneratorScreen extends StatefulWidget {
  const OutfitGeneratorScreen({Key? key}) : super(key: key);

  @override
  _OutfitGeneratorScreenState createState() => _OutfitGeneratorScreenState();
}

class _OutfitGeneratorScreenState extends State<OutfitGeneratorScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];

  Future<void> _uploadImages(String userName) async {
    final directory = await getApplicationDocumentsDirectory();
    final userDirectory = Directory('${directory.path}/$userName');
    if (!await userDirectory.exists()) {
      await userDirectory.create();
    }
    for (final image in _images) {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File('${userDirectory.path}/$fileName');
      await file.writeAsBytes(await image.readAsBytes());
      // Save file path to the database
      await _saveFilePathToDatabase(file.path);
    }
  }

  Future<void> _saveFilePathToDatabase(String filePath) async {
    final database = await openDatabase('my_database.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE images (id INTEGER PRIMARY KEY, file_path TEXT)');
    });

    await database.transaction((txn) async {
      await txn.rawInsert('INSERT INTO images(file_path) VALUES("$filePath")');
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _showUserNameDialog() async {
    final userNameController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter your username'),
          content: TextField(
            controller: userNameController,
            decoration: const InputDecoration(hintText: 'Username'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final userName = userNameController.text.trim();
                if (userName.isNotEmpty) {
                  _uploadImages(userName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Generator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.file(_images[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Add Image'),
          ),
          ElevatedButton(
            onPressed: _showUserNameDialog,
            child: const Text('Upload Images'),
          ),
        ],
      ),
    );
  }
}
