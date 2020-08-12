import 'dart:async';

import 'package:wasteagram/models/wasted_item.dart';

class DocumentToItemTransformer<S, T> extends StreamTransformerBase<S, T> {
  final StreamTransformer<S, T> transformer;

  DocumentToItemTransformer() : transformer = createTransformer();

  @override
  Stream<T> bind(Stream<S> stream) => transformer.bind(stream);

  static StreamTransformer<S, T> createTransformer<S, T>() =>
      new StreamTransformer((Stream inputStream, bool cancelOnError) {
        StreamController controller;
        StreamSubscription subscription;
        controller = new StreamController<T>(
          onListen: () {
            subscription = inputStream.listen((snapshot) {
              List wastedItems = snapshot.documents.map((document) {
                try {
                  return WastedItem.fromDocument(document);
                } catch (err) {
                  // For testing purposes. firestore_mock does not seem to work
                  // in an identical manner to firestore.
                  return WastedItem.fromMap(document.data);
                }
              }).toList();

              controller.add(wastedItems);
            },
                onDone: controller.close,
                onError: controller.addError,
                cancelOnError: cancelOnError);
          },
          onPause: ([Future<dynamic> resumeSignal]) =>
              subscription.pause(resumeSignal),
          onResume: () => subscription.resume(),
          onCancel: () => subscription.cancel(),
        );
        return controller.stream.listen(null);
      });
}
