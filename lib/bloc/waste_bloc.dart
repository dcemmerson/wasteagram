import 'dart:async';
import 'dart:ui';

import 'package:rxdart/rxdart.dart';
import 'package:wasteagram/services/waste_service.dart';

class WasteBloc {
  final WasteService _wasteService;

  //Inputs - coming from app, going to firebase.
  StreamController<AddWasteItem> addWasteItemSink =
      StreamController<AddWasteItem>();

  //Outputs - coming from firebase, going to app.
  Stream<Map> get wastedItems => _wastedItemsStreamController.stream;
  StreamController<Map> _wastedItemsStreamController =
      BehaviorSubject<Map>(seedValue: {});

  WasteBloc(this._wasteService) {
    addWasteItemSink.stream.listen(_handleAddWasteItem);
  }

  void _handleAddWasteItem(AddWasteItem item) {
    _wasteService.addWastedItem(
        name: item.name, count: item.count, date: item.date, image: item.image);
  }

  close() {
    addWasteItemSink.close();
    _wastedItemsStreamController.close();
  }
}

class AddWasteItem {
  final String name;
  final int count;
  final DateTime date;
  final Image image;

  AddWasteItem(this.name, this.count, this.date, this.image);
}
