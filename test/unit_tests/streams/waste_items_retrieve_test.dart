import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';

import '../../mock/mock_waste_service.dart';

void wasteItemsRetrieveTest() {
  WasteBloc wasteBloc;
  group('Test waste list db retrieval with mock', () {
    setUpAll(() {
      wasteBloc = WasteBloc(MockWasteService());
    });

    test('Waste list retrieval from Firebase (ordered)', () async {
      var index = 0;

      await for (var items in wasteBloc.wastedItems) {
        for (var item in items) {
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
        break;
      }
    });
  });
}
