import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

void main() {
  group('Wasteagram integration tests', () {
    final fab = find.byValueKey('addWastePost');
    FlutterDriver driver;

    setUpAll(() async {
      // Grant permissions to access location and use camera in integration
      // test.

      final envVars = Platform.environment;
      final adbPath = join(
        envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'],
        'platform-tools',
        Platform.isWindows ? 'adb.exe' : 'adb',
      );

      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'com.example.wasteagram',
        'android.permission.ACCESS_FINE_LOCATION',
        'android.permission.ACCESS_COURSE_LOCATION',
        'android.permission.CAMERA',
        'android.permission.WRITE_EXTERNAL_STORAGE',
      ]);

      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });
    test('Test waste post tiles appearing', () async {
      print(fab);
      print('call');
      await driver.tap(fab);

      print('\n\n\n\ntapped\n\n\n\n');
    });
  });
}
