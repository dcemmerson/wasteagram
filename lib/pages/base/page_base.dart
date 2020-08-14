import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/routes/routes.dart';
import 'package:wasteagram/styles/theme_manager.dart';
import 'package:wasteagram/widgets/settings/settings_drawer.dart';
import 'package:wasteagram/widgets/settings/settings_drawer_icon.dart';

enum PageType { WastePage, WasteDetailPage, WastePostPage }

abstract class PageBase extends StatelessWidget {
  ThemeManager themeManager;

  PageType get pageType;

  String get pageTitle;
  Widget get body;

  PageBase({Key key}) : super(key: key);

  Widget _buildAppBarFoot() {
    return PreferredSize(
      preferredSize: Size(0, 20),
      child: Container(alignment: Alignment.bottomRight, child: Text('abc')),
    );
  }

  @override
  Widget build(BuildContext context) {
    themeManager =
        ThemeManager(darkMode: WasteagramStateContainer.of(context).isDarkMode);
    if (pageType == PageType.WastePage) {
      return Theme(
          data: themeManager.themeData,
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                title: Text(pageTitle),
                textTheme: Theme.of(context).primaryTextTheme,
                actions: [
                  SettingsDrawerIcon(),
                ],
              ),
              endDrawer: SettingsDrawer(),
              body: body,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: Semantics(
                button: true,
                enabled: true,
                label: 'New Waste Post',
                hint: 'Add new waste post',
                child: FloatingActionButton(
                    key: Key('addWastePost'),
                    onPressed: () => Routes.addWastedPost(context),
                    child: Icon(Icons.add_a_photo)),
              )));
    } else {
      return Theme(
          data: themeManager.themeData,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              title: Text(pageTitle),
              textTheme: Theme.of(context).primaryTextTheme,
              actions: [SettingsDrawerIcon()],
            ),
            endDrawer: SettingsDrawer(),
            body: body,
          ));
    }
  }
}
