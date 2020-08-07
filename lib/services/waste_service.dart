import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class WasteService {
  Stream<QuerySnapshot> wastedItems() {
    return Firestore.instance.collection('wasteagram').snapshots();
  }

  Future addWastedItem({String name, int count, Image image, DateTime date}) {
    var imageUrl = 'temp';
    return Firestore.instance.collection('wasteagram').add(
        {'name': name, 'count': count, 'imageUrl': imageUrl, 'date': date});
  }
}
