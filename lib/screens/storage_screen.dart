import 'package:flutter/material.dart';
import 'package:dermoscan/sqlite/login_db.dart';
import 'package:dermoscan/models/previous_scan_result.dart';
import 'dart:typed_data';
import 'package:dermoscan/screens/FullImageScreen.dart';



class StorageScreen extends StatefulWidget {
  final int userId;

  StorageScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late List<PreviousScanResult> _previousScanResults = [];

  @override
  void initState() {
    super.initState();
    _loadPreviousScanResults();
  }

  Future<void> _loadPreviousScanResults() async {
    _previousScanResults = await _databaseHelper.getPreviousScanResults(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _previousScanResults.length,
        itemBuilder: (context, index) {
          final result = _previousScanResults[index];
          return Card(
            child: InkWell(
              onTap: () {
                _showFullImage(context, result.scanImage!, result.scanResult);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (result.scanImage != null)
                    Image.memory(
                      Uint8List.fromList(result.scanImage!),
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ListTile(
                    title: Text('Date: ${result.scanDate}'),
                    subtitle: Text('Result: ${result.scanResult}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullImage(BuildContext context, Uint8List image, String result) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullImageScreen(image: image, result: result),
      ),
    );
  }
}

