import 'package:flutter/material.dart';
import 'package:wasteagram/pages/base/page_base.dart';
import 'package:wasteagram/pages/base/page_container.dart';
import 'package:wasteagram/pages/waste_page.dart';

class Routes {
  static final routes = {
    WastePage.route: (context) => PageContainer(pageType: PageType.WastePage),
  };

  static Future wastePage(BuildContext context) {
    return Navigator.pushNamed(context, WastePage.route);
  }

  static Future addWastedPost(BuildContext context) {
    return Navigator.pushNamed(context, WastePage.route);
  }
}
