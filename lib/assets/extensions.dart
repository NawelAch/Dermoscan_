import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension Uint8ListImageProvider on Uint8List {
  ImageProvider<Object> get imageProvider {
    return MemoryImage(this);
  }
}
