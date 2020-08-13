import 'package:flutter/material.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/utils/date.dart';
import 'package:wasteagram/styles/styles.dart';

class WasteItemDetail extends StatelessWidget {
  Widget _imageFromNetwork(String url) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return Center(
              child: Padding(
                  padding: EdgeInsets.all(AppPadding.p6),
                  child: LinearProgressIndicator(
                      value: loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes)));
        }
        return Expanded(child: FittedBox(fit: BoxFit.fill, child: child));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WastedItem item = ModalRoute.of(context).settings.arguments as WastedItem;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text(
                    Date.dayOfWeek(item.date) +
                        ', ' +
                        Date.humanizeTimestamp(item.date),
                    style: TextStyle(fontSize: AppFonts.h1)))),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text('Item: ' + item.name,
                    style: TextStyle(fontSize: AppFonts.h4))),
            Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text('Count: ' + item.count.toString(),
                    style: TextStyle(fontSize: AppFonts.h6))),
          ],
        ),
        _imageFromNetwork(item.imageUrl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gps_not_fixed),
            Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text('Lat: ' + item.location.latitude.toString(),
                    style: TextStyle(fontSize: AppFonts.h6))),
            Padding(
                padding: EdgeInsets.all(AppPadding.p4),
                child: Text('Lng: ' + item.location.longitude.toString(),
                    style: TextStyle(fontSize: AppFonts.h6))),
          ],
        ),
      ],
    );
  }
}
