import 'package:flutter_driver/driver_extension.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';
import 'package:wasteagram/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  // Required to allow integration tests access to location services and
  // device camera.
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/image_picker');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    ByteData data = await rootBundle.load('testing/test_image.jpeg');
    Uint8List bytes = data.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    File file = await File(
      '${tempDir.path}/tmp.tmp',
    ).writeAsBytes(bytes);
    print(file.path);
    return file.path;
  });
  app.main();
}
