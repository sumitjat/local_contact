import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ImageUtils {
  static MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(
      base64Decode(base64String),
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
