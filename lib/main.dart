import 'dart:io'; 

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bildergalerie',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<XFile> _selectedImages = [];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker(); // Benenne _picker zu picker um
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImages.add(image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bildergalerie'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Bild auswählen'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Image.file(File(_selectedImages[index].path)), // Füge 'File' hinzu
                  onTap: () => _removeImage(index), // Bonus: Bild entfernen
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
