import 'package:flutter/material.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/pages/base/page_base.dart';
import 'package:wasteagram/pages/base/page_container.dart';
import 'package:wasteagram/pages/authentication_page.dart';
import 'package:wasteagram/pages/waste_list_page.dart';
import 'package:wasteagram/pages/waste_detail_page.dart';
import 'package:wasteagram/pages/waste_post_page.dart';

class Routes {
  static final routes = {
    AuthenticationPage.route: (context) =>
        PageContainer(pageType: PageType.AuthenticationPage),
    WasteListPage.route: (context) =>
        PageContainer(pageType: PageType.WastePage),
    WasteDetailPage.route: (context) =>
        PageContainer(pageType: PageType.WasteDetailPage),
    WastePostPage.route: (context) =>
        PageContainer(pageType: PageType.WastePostPage),
  };

  static Future wastePage(BuildContext context) {
    return Navigator.pushNamed(context, WasteListPage.route);
  }

  static Future wasteDetailPage(BuildContext context,
      {@required WastedItem item}) {
    return Navigator.pushNamed(context, WasteDetailPage.route, arguments: item);
  }

  static Future addWastedPost(BuildContext context) {
    return Navigator.pushNamed(context, WastePostPage.route);
  }
}
