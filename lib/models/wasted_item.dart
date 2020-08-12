import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class WastedItem {
  final String name;
  final double count;
  final Image image;
  final String imageUrl;
  final Timestamp date;
  final GeoPoint location;

  const WastedItem(
      {this.name,
      this.count,
      this.image,
      this.imageUrl,
      this.date,
      this.location});

  WastedItem.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.count = map['count'].toDouble(),
        this.image = map['image'],
        this.imageUrl = map['imageUrl'],
        this.date = map['date'],
        this.location = map['locationData'];

  WastedItem.fromDocument(DocumentSnapshot doc)
      : this.name = doc['name'],
        this.count = doc['count'].toDouble(),
        this.image = doc['image'],
        this.imageUrl = doc['imageUrl'],
        this.date = doc['date'],
        this.location = doc['location'];

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
