import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class WastedItem {
  final String name;
  final double count;
  final Image image;
  final String imageUrl;
  final Timestamp date;
  final GeoPoint location;

  const WastedItem({
    this.name,
    this.count,
    this.image,
    this.imageUrl,
    this.date,
    this.location,
  });

  WastedItem.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.count = map['count'].toDouble(),
        this.image = map['image'],
        this.imageUrl = map['imageUrl'],
        this.date = map['date'],
        this.location = map['location'];

  WastedItem.fromDocument(DocumentSnapshot doc)
      : this.name = doc.data()['name'],
        this.count = doc.data()['count'].toDouble(),
        this.image = doc.data()['image'],
        this.imageUrl = doc.data()['imageUrl'],
        this.date = doc.data()['date'],
        this.location = doc.data()['location'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'count': count,
      'image': image,
      'imageUrl': imageUrl,
      'date': date,
    };
  }
}
