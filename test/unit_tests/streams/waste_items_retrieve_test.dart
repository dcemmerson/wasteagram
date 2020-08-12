import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';

import '../../mock/mock_waste_service.dart';

void wasteItemsRetrieveTest() {
  WasteBloc wasteBloc;
  group('Test photo taken sink and stream', () {
    setUpAll(() {
      wasteBloc = WasteBloc(MockWasteService());
    });

    test('Waste list retrieval from Firebase (ordered)', () async {
      var index = 0;

      await for (var items in wasteBloc.wastedItems) {
        for (var item in items) {
          print(item.date.toString() + ', ' + item.name.toString());
          expect(item.name, MockWasteService.mockWasteItems[index].name);
          expect(item.count, MockWasteService.mockWasteItems[index].count);
          expect(item.date, MockWasteService.mockWasteItems[index].date);
          expect(
              item.imageUrl, MockWasteService.mockWasteItems[index].imageUrl);
          expect(item.location.latitude,
              MockWasteService.mockWasteItems[index].location.latitude);
          expect(item.location.longitude,
              MockWasteService.mockWasteItems[index].location.longitude);

          index++;
        }
      }
      // expect(wasteBloc.wastedItems,
      //     emitsInOrder(MockWasteService.orderedMockWasteItems));
    });
  });
}
