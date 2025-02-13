import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<XFile> compressXFile(XFile xfile) async {
  // Get temporary directory to save compressed image
  Directory tempDir = await getTemporaryDirectory();
  String targetPath = '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

  // Compress image
  XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
    xfile.path,  // Input file path
    targetPath,  // Output file path
    quality: 80, // Adjust quality (0-100)
    minWidth: 800,
    minHeight: 800,
  );

  // If compression fails, return original file
  return compressedXFile ?? xfile;
}
