import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Wasteagram integration tests', () {
    final sampleItem = {
      'name': 'This is an integration test',
      'count': '13',
      'dayOfMonth': '1'
    };

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
    test(
        'Test: Add new waste post, verify waste post appears in listview, ' +
            'finally verify waste post appear in detail view', () async {
      await Future.delayed(Duration(seconds: 2));

      await driver.tap(fab);

      //  Tap name field and enter 'This is only a test...'
      final nameField = find.byValueKey('itemNameField');
      await driver.tap(nameField);
      await driver.enterText(sampleItem['name']);
      await Future.delayed(Duration(seconds: 2));

      //  Scroll to button and try submitting form. Shouldn't allow submission,
      //  and rest of test should be allowed to continue.
      final buttonField = find.byValueKey('itemUploadButton');
      await driver.scrollIntoView(buttonField, timeout: Duration(seconds: 5));
      await driver.tap(buttonField);

      //  We shouldn't need to scroll back up screen. App should autofocus
      // for us.
      //  Tap item count field and enter 13.
      final countField = find.byValueKey('itemCountField');
      await driver.tap(countField);
      await driver.enterText(sampleItem['count']);
      await Future.delayed(Duration(seconds: 2));
      //  Tap date to 1st of the month.
      final dateField = find.byValueKey('itemDateField');
      await driver.tap(dateField);
      await driver.tap(find.text(sampleItem['dayOfMonth']));
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(find.text('OK'));
      await Future.delayed(Duration(seconds: 1));

      await driver.tap(find.text('OK'));
      await Future.delayed(Duration(seconds: 1));

      //  Now scroll until upload button is on screen and submit form.
      await driver.scrollIntoView(buttonField, timeout: Duration(seconds: 5));
      await driver.tap(buttonField);
      await Future.delayed(Duration(seconds: 1));

      //  Wasted item should have been successfully submitted to storage, and
      //  we now want to verify that the item does appear in our list view.
      //  Tap that item and verify details.

      //  Parse double, then find.text since WastedItem model stores count as
      //  double, the key we are looking for will be a double
      await driver.tap(find.byValueKey(
          sampleItem['name'] + double.parse(sampleItem['count']).toString()));
      //  We should be on the item details screen, so search for name, count,
      //  and date and verify these all exist.
      find.text(sampleItem['name']);

      await Future.delayed(Duration(seconds: 2));

      find.text(sampleItem['count']);
      var date = DateTime.now();
      String dateToVerify = stringDay(date.weekday) +
          ', ' +
          sampleItem['dayOfMonth'] +
          ' ' +
          stringMonth(date.month) +
          ' ' +
          date.year.toString();

      find.text(dateToVerify);
    });
  });
}

//  Define these functions here as the 'equivalent' functions in actual app
//  convert Firebase Timestamp into dates, which will prevent our integration
//  tests from running if we import into these integration tests.
String stringDay(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thu';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return 'unknown';
  }
}

String stringMonth(int weekday) {
  switch (weekday) {
    case DateTime.january:
      return 'Jan';
    case DateTime.february:
      return 'Feb';
    case DateTime.march:
      return 'Mar';
    case DateTime.april:
      return 'Apr';
    case DateTime.may:
      return 'May';
    case DateTime.june:
      return 'Jun';
    case DateTime.july:
      return 'Jul';
    case DateTime.august:
      return 'Aug';
    case DateTime.september:
      return 'Sep';
    case DateTime.october:
      return 'Oct';
    case DateTime.november:
      return 'Nov';
    case DateTime.december:
      return 'Dec';
    default:
      return 'unknown';
  }
}
