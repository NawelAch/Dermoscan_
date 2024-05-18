import 'package:flutter/material.dart';
import 'dart:typed_data';
class FullImageScreen extends StatelessWidget {
  final Uint8List image;
  final String result;

  FullImageScreen({required this.image, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.memory(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
