import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/wasted_item.dart';

void modelTest() {
  var wastedPostEntry;

  group('Waste Item Model', () {
    setUp(() {
      wastedPostEntry = {
        'name': 'anItem',
        'count': 2.0,
        'image': null,
        'imageUrl': 'fakeUrl',
        'date': Timestamp((DateTime.now().millisecondsSinceEpoch ~/ 1000), 0),
        'location': GeoPoint(32.787275, -117.137544),
      };
    });

    test('WasteItem.toMap()', () {
      var wastedItem = WastedItem(
        name: wastedPostEntry['name'],
        count: wastedPostEntry['count'],
        image: wastedPostEntry['image'],
        imageUrl: wastedPostEntry['imageUrl'],
        date: wastedPostEntry['date'],
        location: wastedPostEntry['location'],
      );

      expect(wastedItem.name, wastedPostEntry['name']);
      expect(wastedItem.count, wastedPostEntry['count']);
      expect(wastedItem.image, wastedPostEntry['image']);
      expect(wastedItem.imageUrl, wastedPostEntry['imageUrl']);
      expect(wastedItem.date, wastedPostEntry['date']);
      expect(wastedItem.location, wastedPostEntry['location']);
    });
    test('WastedItem.fromMap()', () {
      var wastedItem = WastedItem.fromMap(wastedPostEntry);
      expect(wastedItem.name, wastedPostEntry['name']);
      expect(wastedItem.count, wastedPostEntry['count']);
      expect(wastedItem.image, wastedPostEntry['image']);
      expect(wastedItem.imageUrl, wastedPostEntry['imageUrl']);
      expect(wastedItem.date, wastedPostEntry['date']);
      expect(wastedItem.location, wastedPostEntry['location']);
    });
  });
}
