import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wasteagram/bloc/stream_transformers/item_transformer.dart';
import 'package:wasteagram/services/network/waste_service.dart';

class WasteBloc {
  final WasteService _wasteService;

  //Inputs - coming from wasteagram.
  StreamController<AddWasteItem> addWasteItemSink =
      StreamController<AddWasteItem>();
  StreamController<PhotoTaken> photoTakenSink = StreamController<PhotoTaken>();

  //Outputs - either going to wasteagram or uses services to Firebase.
  Stream<List> get wastedItems => _wastedItemsStreamController.stream;
  StreamController<List> _wastedItemsStreamController =
      BehaviorSubject<List>(seedValue: null);

  Stream<PhotoTaken> get photoTaken => _photoTakenStreamController.stream;
  StreamController<PhotoTaken> _photoTakenStreamController =
      BehaviorSubject<PhotoTaken>(seedValue: null);

  WasteBloc(this._wasteService) {
    addWasteItemSink.stream.listen(_handleAddWasteItem);
    photoTakenSink.stream.listen(_handlePhotoTaken);

    _wasteService.wastedItems
        .transform(DocumentToItemTransformer())
        .listen((items) {
      _wastedItemsStreamController.add(items);
    });
  }

  void _handleAddWasteItem(AddWasteItem item) {
    item.date.millisecondsSinceEpoch;
    _wasteService.addWastedItem(
        name: item.name,
        count: item.count,
        date: item.date,
        photo: item.photo,
        locationData: item.locationData);
  }

  void _handlePhotoTaken(PhotoTaken photoTaken) {
    _photoTakenStreamController.add(photoTaken);
  }

  close() {
    addWasteItemSink.close();
    _wastedItemsStreamController.close();
    photoTakenSink.close();
    _photoTakenStreamController.close();
  }
}

class AddWasteItem {
  String name;
  int count;
  DateTime date;
  File photo;
  LocationData locationData;

  // AddWasteItem.fromMap({
  //   @required this.name,
  //   @required this.count,
  //   @required this.date,
  //   @required this.photo,
  //   @required this.locationData,
  // });
}

class PhotoTaken {
  final File photo;
  final LocationData locationData;

  PhotoTaken({@required this.photo, @required this.locationData});
}
