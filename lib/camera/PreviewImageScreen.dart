import 'dart:io';

import 'package:flutter/material.dart';

class PreviewImageScreen extends StatefulWidget {
  String imagePath;
   PreviewImageScreen({super.key,required this.imagePath});

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Image.file(File(widget.imagePath)))
        ],
      ),
    );
  }
}
