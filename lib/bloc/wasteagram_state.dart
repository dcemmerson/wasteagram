import 'package:flutter/material.dart';

import 'bloc_provider.dart';

class WasteagramStateContainer extends StatefulWidget {
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
  BlocProvider get blocProvider => widget.blocProvider;

  @override
  Widget build(BuildContext context) {
    return _WasteagramContainer(
      wasteagramState: this,
      blocProvider: widget.blocProvider,
      child: widget.child,
    );
  }
}

class _WasteagramContainer extends InheritedWidget {
  final WasteagramState wasteagramState;
  final BlocProvider blocProvider;

  _WasteagramContainer(
      {Key key,
      @required this.wasteagramState,
      @required Widget child,
      @required this.blocProvider})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_WasteagramContainer oldWidget) =>
      oldWidget.wasteagramState != this.wasteagramState;
}
