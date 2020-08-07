import 'package:flutter/material.dart';
import 'package:wasteagram/pages/base/page_base.dart';
import 'package:wasteagram/pages/waste_page.dart';
import 'package:wasteagram/utils/styles.dart';

class PageContainer extends PageBase {
  final PageType pageType;

  PageContainer({Key key, @required this.pageType}) : super(key: key);
  @override
  Color get backgroundColor => AppColors.background;

  @override
  Widget get body {
    var page;
    switch (pageType) {
      case PageType.WastePage:
        page = WastePage();
        break;
      default:
        page = WastePage();
    }
    return Padding(
      padding: EdgeInsets.zero,
      child: page,
    );
  }

  @override
  String get pageTitle {
    switch (pageType) {
      case PageType.WastePage:
        return WastePage.title;
      default:
        return 'Welcome';
    }
  }
}
