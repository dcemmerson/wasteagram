import 'dart:async';
import 'dart:ui';

import 'package:rxdart/rxdart.dart';
import 'package:wasteagram/bloc/stream_transformers/item_transformer.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/services/waste_service.dart';

class WasteBloc {
  final WasteService _wasteService;

  //Inputs - coming from wasteagram.
  StreamController<AddWasteItem> addWasteItemSink =
      StreamController<AddWasteItem>();

  //Outputs - either going to wasteagram or uses services to Firebase.
  Stream<List> get wastedItems => _wastedItemsStreamController.stream;
  StreamController<List> _wastedItemsStreamController =
      BehaviorSubject<List>(seedValue: null);

  WasteBloc(this._wasteService) {
    addWasteItemSink.stream.listen(_handleAddWasteItem);
    _wasteService.wastedItems
        .transform(DocumentToItemTransformer())
        .listen((items) {
      _wastedItemsStreamController.add(items);
    });
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
