import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/widgets/waste_list_view/compact_list_tile.dart';
import 'package:wasteagram/widgets/waste_list_view/empty_post.dart';
import 'package:wasteagram/widgets/waste_list_view/expanded_list_tile.dart';

class WasteItems extends StatefulWidget {
  @override
  _WasteItemsState createState() => _WasteItemsState();
}

class _WasteItemsState extends State<WasteItems> {
  WasteBloc _bloc;
  bool _isCompactListTileMode;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WasteagramStateContainer.of(context).blocProvider.wasteBloc;
    _isCompactListTileMode =
        WasteagramStateContainer.of(context).isCompactWasteListMode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
      stream: _bloc.wastedItems,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        if (snapshot.data.length < 1) {
          return EmptyPostList();
        } else {
          if (_isCompactListTileMode) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Semantics(
                    value: snapshot.data[index].name,
                    child: CompactListTile(wastedItem: snapshot.data[index])));
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Semantics(
                    value: snapshot.data[index].name,
                    child: ExpandedListTile(wastedItem: snapshot.data[index])));
          }
        }
      },
    ));
  }
}
