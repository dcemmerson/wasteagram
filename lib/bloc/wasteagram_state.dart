import 'package:flutter/material.dart';

import 'bloc_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WasteagramStateContainer extends StatefulWidget {
  static const initDarkMode = false;
  static const initCompactWasteListMode = true;
  static const prefsDarkMode = 'darkMode';
  static const prefsCompactWasteListMode = 'compactMode';
  static const prefsAllUsersEntries = 'allUsersEntries';

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
  bool _isDarkMode = false;
  bool _isCompactWasteListMode = true;
  bool _allUsersEntries = true;

  get isDarkMode => _isDarkMode;
  get isCompactWasteListMode => _isCompactWasteListMode;
  get allUsersEntries => _allUsersEntries;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    var initialDarkMode =
        _prefs.getBool(WasteagramStateContainer.prefsDarkMode);

    var initialCompactWasteListMode =
        _prefs.getBool(WasteagramStateContainer.prefsCompactWasteListMode);

    setState(() {
      _isDarkMode = initialDarkMode is bool
          ? initialDarkMode
          : WasteagramStateContainer.initDarkMode;
      _isCompactWasteListMode = initialCompactWasteListMode is bool
          ? initialCompactWasteListMode
          : WasteagramStateContainer.initCompactWasteListMode;
    });
  }

  void toggleDarkMode() {
    _prefs.setBool(WasteagramStateContainer.prefsDarkMode, !_isDarkMode);
    setState(() => _isDarkMode = !_isDarkMode);
  }

  void toggleAllUsersEntries() {
    _prefs.setBool(
        WasteagramStateContainer.prefsAllUsersEntries, !_allUsersEntries);
    setState(() => _allUsersEntries = !_allUsersEntries);
  }

  void toggleCompactWasteListMode() {
    _prefs.setBool(WasteagramStateContainer.prefsCompactWasteListMode,
        !_isCompactWasteListMode);
    setState(() => _isCompactWasteListMode = !_isCompactWasteListMode);
  }

  @override
  Widget build(BuildContext context) {
    return _WasteagramContainer(
      wasteagramState: this,
      isDarkMode: _isDarkMode,
      isCompactWasteListMode: _isCompactWasteListMode,
      allUsersEntries: _allUsersEntries,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }
}

class _WasteagramContainer extends InheritedWidget {
  final WasteagramState wasteagramState;
  final BlocProvider blocProvider;
  final bool isDarkMode;
  final bool isCompactWasteListMode;
  final bool allUsersEntries;

  _WasteagramContainer({
    Key key,
    @required this.wasteagramState,
    @required Widget child,
    @required this.blocProvider,
    @required this.isDarkMode,
    @required this.allUsersEntries,
    @required this.isCompactWasteListMode,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_WasteagramContainer oldWidget) {
    return oldWidget.wasteagramState != this.wasteagramState ||
        oldWidget.isDarkMode != this.isDarkMode ||
        oldWidget.isCompactWasteListMode != this.isCompactWasteListMode ||
        oldWidget.allUsersEntries != this.allUsersEntries;
  }
}
