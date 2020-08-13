import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WasteagramStateContainer extends StatefulWidget {
  static const prefsDarkMode = 'darkMode';

  final Widget child;
  final BlocProvider blocProvider;

  const WasteagramStateContainer(
      {Key key, @required this.child, @required this.blocProvider})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => WasteagramState();

  static WasteagramState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_WasteagramContainer)
            as _WasteagramContainer)
        .wasteagramState;
  }
}

class WasteagramState extends State<WasteagramStateContainer> {
  SharedPreferences _prefs;

  BlocProvider get blocProvider => widget.blocProvider;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    var initialDarkMode =
        _prefs.getBool(WasteagramStateContainer.prefsDarkMode);
    setState(
        () => isDarkMode = initialDarkMode is bool ? initialDarkMode : false);
  }

  void toggleDarkMode() {
    _prefs.setBool(WasteagramStateContainer.prefsDarkMode, !isDarkMode);

    setState(() => isDarkMode = !isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return _WasteagramContainer(
      wasteagramState: this,
      isDarkMode: isDarkMode,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }
}

class _WasteagramContainer extends InheritedWidget {
  final WasteagramState wasteagramState;
  final BlocProvider blocProvider;
  final bool isDarkMode;

  _WasteagramContainer({
    Key key,
    @required this.wasteagramState,
    @required Widget child,
    @required this.blocProvider,
    @required this.isDarkMode,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_WasteagramContainer oldWidget) {
    return oldWidget.wasteagramState != this.wasteagramState ||
        oldWidget.isDarkMode != this.isDarkMode;
  }
}
