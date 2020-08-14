import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_mock/firestore_mock.dart';
import 'package:wasteagram/models/wasted_item.dart';

import 'package:wasteagram/services/network/waste_service.dart';

class MockWasteService extends WasteService {
  static List<WastedItem> mockWasteItems = [
    WastedItem.fromMap(mockData['foodWaste']['document_id_1']),
    WastedItem.fromMap(mockData['foodWaste']['document_id_2']),
    WastedItem.fromMap(mockData['foodWaste']['document_id_3']),
  ];

  static Map<String, dynamic> mockData = {
    "foodWaste": {
      "document_id_1": {
        "name": "First item",
        "count": 107,
        "location": GeoPoint(32.010122, -177.912112),
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/wasteagram-d2a0f.appspot.com/o/storage%2Femulated%2F0%2FAndroid%2Fdata%2Fcom.example.wasteagram%2Ffiles%2FPictures%2F700af5f8-c4ca-41e3-90a7-4430d965f2aa1508630476137425932.jpg1597159860000?alt=media&token=87e7a985-d767-40f6-ba78-be472cc2b9ed",
        "date": Timestamp(
            ((DateTime.now().millisecondsSinceEpoch ~/ 1000) + 320211), 0),
      },
      "document_id_2": {
        "name": "Here . is ..a? nother item/>2",
        "count": 12,
        "location": GeoPoint(32.010122, -177.912112),
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/wasteagram-d2a0f.appspot.com/o/storage%2Femulated%2F0%2FAndroid%2Fdata%2Fcom.example.wasteagram%2Ffiles%2FPictures%2Fc9fa398e-4aea-477d-9b4e-790d4c89811c833970721834524639.jpg1597505580000?alt=media&token=6ea46e4f-f4bb-47c9-b7b0-49e1a698e81d",
        "date": Timestamp(
            ((DateTime.now().millisecondsSinceEpoch ~/ 1000) - 1000987), 0),
      },
      "document_id_3": {
        "name": "Here ..1!@(#*&# &*&^/.<html />)",
        "count": 12,
        "location": GeoPoint(32.010122, -177.912112),
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/wasteagram-d2a0f.appspot.com/o/storage%2Femulated%2F0%2FAndroid%2Fdata%2Fcom.example.wasteagram%2Ffiles%2FPictures%2Fc9fa398e-4aea-477d-9b4e-790d4c89811c833970721834524639.jpg1597505580000?alt=media&token=6ea46e4f-f4bb-47c9-b7b0-49e1a698e81d",
        "date": Timestamp((DateTime.now().millisecondsSinceEpoch ~/ 1000), 0),
      },
    }
  };
  MockFirestore mockFirebase = MockFirestore(data: mockData);

  Stream<QuerySnapshot> get wastedItems {
    return mockFirebase
        .collection('foodWaste')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
