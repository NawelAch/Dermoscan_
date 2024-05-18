import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:dermoscan/sqlite/login_db.dart';
import 'dart:typed_data';

class ResultsScreen extends StatefulWidget {
  final File image;
  final int userId;

  ResultsScreen({required this.image, required this.userId});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late List _results = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    loadModel();
    classifyImage(widget.image);
  }

  Future loadModel() async {
    Tflite.close();
    String res;
    res = (await Tflite.loadModel(
      model: "lib/assets/tflite_model.tflite",
      labels: "lib/assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    ))!;
    print("Models loading status: $res");
  }

  Future classifyImage(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 0.0,
      imageStd: 1.0,
    );
    setState(() {
      _results = recognitions!;
      _saveScanResult();
    });
  }

  Future<void> _saveScanResult() async {
    final DateTime now = DateTime.now();
    final String formattedDate = '${now.year}-${now.month}-${now.day}';
    final String scanResult = _results.isNotEmpty ? _results[0]['label'] : 'Unknown';
    final Uint8List scanImage = (await widget.image.readAsBytes());
    await _databaseHelper.saveScanResult(widget.userId, formattedDate, scanResult, scanImage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Results'),
      ),
      body: Column(
        children: [
          Center(
            child: Image.file(widget.image),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _results.map((result) {
                  return Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "${result['label']} - ${result['confidence'].toStringAsFixed(2)}",
                        style: const TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}