import 'dart:typed_data';

class PreviousScanResult {
  final int id;
  final int userId;
  final String scanDate;
  final String scanResult;
  final Uint8List? scanImage; // Nullable Uint8List for storing image data

  PreviousScanResult({
    required this.id,
    required this.userId,
    required this.scanDate,
    required this.scanResult,
    this.scanImage, // Updated to include scanImage
  });

  factory PreviousScanResult.fromMap(Map<String, dynamic> map) {
    return PreviousScanResult(
      id: map['id'],
      userId: map['userId'],
      scanDate: map['scanDate'],
      scanResult: map['scanResult'],
      scanImage: map['scanImage'], // Assign scanImage from map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'scanDate': scanDate,
      'scanResult': scanResult,
      'scanImage': scanImage, // Include scanImage in the map
    };
  }
}