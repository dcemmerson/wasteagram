import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';

class WasteService {
  Stream<QuerySnapshot> get wastedItems {
    return FirebaseFirestore.instance
        .collection('foodWaste')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future addWastedItem(
      {String name,
      int count,
      File photo,
      DateTime date,
      LocationData locationData}) async {
    final StorageReference ref = FirebaseStorage()
        .ref()
        .child(photo.path + date.millisecondsSinceEpoch.toString());
    final StorageUploadTask uploadTask =
        ref.putFile(photo, StorageMetadata(contentLanguage: 'en'));

    await uploadTask.onComplete;
    await FirebaseFirestore.instance.collection('foodWaste').add({
      'name': name,
      'count': count,
      'imageUrl': await ref.getDownloadURL(),
      'date': date,
      'location': GeoPoint(locationData.latitude, locationData.longitude),
    });
  }
}
