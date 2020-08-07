import 'package:flutter/material.dart';
import 'package:wasteagram/pages/base/page_base.dart';
import 'package:wasteagram/pages/waste_detail_page.dart';
import 'package:wasteagram/pages/waste_page.dart';
import 'package:wasteagram/pages/waste_post_page.dart';
import 'package:wasteagram/utils/styles.dart';

class PageContainer extends PageBase {
  final PageType _pageType;

  PageContainer({Key key, @required pageType})
      : this._pageType = pageType,
        super(key: key);

  @override
  Color get backgroundColor => AppColors.background;

  @override
  Widget get body {
    var page;
    switch (pageType) {
      case PageType.WastePage:
        page = WastePage();
        break;
      case PageType.WasteDetailPage:
        page = WasteDetailPage();
        break;
      case PageType.WastePostPage:
        page = WastePostPage();
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
