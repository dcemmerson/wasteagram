import 'package:flutter/material.dart';
import 'package:wasteagram/pages/base/page_base.dart';
import 'package:wasteagram/pages/waste_detail_page.dart';
import 'package:wasteagram/pages/waste_list_page.dart';
import 'package:wasteagram/pages/waste_post_page.dart';

class PageContainer extends PageBase {
  final PageType _pageType;

  PageContainer({Key key, @required pageType})
      : this._pageType = pageType,
        super(key: key);

  @override
  Widget get body {
    var page;
    switch (pageType) {
      case PageType.WastePage:
        page = WasteListPage();
        break;
      case PageType.WasteDetailPage:
        page = WasteDetailPage();
        break;
      case PageType.WastePostPage:
        page = WastePostPage();
        break;
      default:
        page = WasteListPage();
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
        return WasteListPage.title;
      case PageType.WasteDetailPage:
        return WasteDetailPage.title;
      case PageType.WastePostPage:
        return WastePostPage.title;
      default:
        return 'Welcome';
    }
  }

  PageType get pageType => this._pageType;
}
