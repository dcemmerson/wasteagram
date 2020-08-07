import 'package:flutter/material.dart';
import 'package:wasteagram/routes/routes.dart';

enum PageType { WastePage, WasteDetailPage, WastePostPage }

abstract class PageBase extends StatelessWidget {
  PageType get pageType;

  Color get backgroundColor;
  String get pageTitle;
  Widget get body;

  const PageBase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pageType == PageType.WastePage) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(pageTitle),
          textTheme: Theme.of(context).primaryTextTheme,
          actions: <Widget>[
//              AppBarCartIcon(),
          ],
        ),
        //         drawer: menuDrawer,
        body: body,
        floatingActionButton: FloatingActionButton(
            onPressed: () => Routes.addWastedPost(context),
            child: Icon(Icons.add_a_photo)),
      );
    } else {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(pageTitle),
          textTheme: Theme.of(context).primaryTextTheme,
          actions: <Widget>[
//              AppBarCartIcon(),
          ],
        ),
        //         drawer: menuDrawer,
        body: body,
      );
    }
  }
}
