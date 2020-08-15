import 'package:flutter/material.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/routes/routes.dart';
import 'package:wasteagram/styles/sizing.dart';
import 'package:wasteagram/styles/styles.dart';
import 'package:wasteagram/utils/date.dart';

class ExpandedListTile extends StatelessWidget {
  final WastedItem wastedItem;

  ExpandedListTile({this.wastedItem});

  Widget _imageFromNetwork(String url) {
    return Image.network(
      url,
      loadingBuilder: (ctx, child, loadingProgress) {
        if (loadingProgress != null) {
          return Container(
              child: Padding(
                  padding: EdgeInsets.all(AppPadding.p6),
                  child: LinearProgressIndicator(
                      value: loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes)));
        }

        return Expanded(
            child: FittedBox(
          fit: BoxFit.fill,
          child: child,
        ));
      },
    );
  }

  Size _calculateImageSize(BuildContext ctx) {
    if (MediaQuery.of(ctx).orientation == Orientation.portrait) {
      return Sizing.byPercentages(
          widthPercentage: 100, heightPercentage: 40, context: ctx);
    } else {
      return Sizing.byPercentages(
          widthPercentage: 100, heightPercentage: 66, context: ctx);
    }
  }

  Widget _buildBasedOnDeviceOrientation(BuildContext ctx) {
    if (MediaQuery.of(ctx).orientation == Orientation.portrait) {
      return _portraitView(Sizing.byPercentages(
          widthPercentage: 100, heightPercentage: 40, context: ctx));
    } else {
      return _landscapeView(Sizing.byPercentages(
          widthPercentage: 100, heightPercentage: 66, context: ctx));
    }
  }

  Widget _landscapeView(Size size) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _imageFromNetwork(wastedItem.imageUrl),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(AppPadding.p1, AppPadding.p6,
                      AppPadding.p1, AppPadding.p6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                            child: Text(
                          Date.humanizeTimestamp(wastedItem.date) +
                              ' (' +
                              Date.dayOfWeek(wastedItem.date) +
                              ')',
                          style: TextStyle(fontSize: AppFonts.h3),
                        )),
                      ])),
              Container(
                padding: EdgeInsets.fromLTRB(
                    AppPadding.p1, AppPadding.p3, AppPadding.p1, AppPadding.p3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.all(AppPadding.p4),
                            child: Text(wastedItem.name,
                                style: TextStyle(fontSize: AppFonts.h4)))),
                    Flexible(
                        child: Padding(
                            padding: EdgeInsets.all(AppPadding.p4),
                            child: Text(wastedItem.count.toString())))
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _portraitView(Size size) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Flexible(
            child: Text(
          Date.humanizeTimestamp(wastedItem.date) +
              ' (' +
              Date.dayOfWeek(wastedItem.date) +
              ')',
          style: TextStyle(fontSize: AppFonts.h3),
        )),
      ]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 3,
              child: Padding(
                  padding: EdgeInsets.all(AppPadding.p4),
                  child: Text(wastedItem.name,
                      style: TextStyle(fontSize: AppFonts.h5)))),
          Flexible(
              child: Padding(
                  padding: EdgeInsets.all(AppPadding.p4),
                  child: Text(wastedItem.count.toString(),
                      style: TextStyle(fontSize: AppFonts.h5))))
        ],
      ),
      _imageFromNetwork(wastedItem.imageUrl),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Size containerSize = _calculateImageSize(context);

    return Card(
        margin: EdgeInsets.fromLTRB(
            AppPadding.p0, AppPadding.p4, AppPadding.p0, AppPadding.p3),
        child: ListTile(
          key: ValueKey(wastedItem.name + wastedItem.count.toString()),
          contentPadding: EdgeInsets.all(AppPadding.p0),
          title: Container(
            height: containerSize.height,
            child: _buildBasedOnDeviceOrientation(context),
          ),
          onTap: () => Routes.wasteDetailPage(context, item: wastedItem),
        ));
  }
}
