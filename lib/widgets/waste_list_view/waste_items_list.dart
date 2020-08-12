import 'package:flutter/material.dart';
import 'package:wasteagram/bloc/waste_bloc.dart';
import 'package:wasteagram/bloc/wasteagram_state.dart';
import 'package:wasteagram/models/wasted_item.dart';
import 'package:wasteagram/routes/routes.dart';
import 'package:wasteagram/utils/date.dart';
import 'package:wasteagram/utils/styles.dart';
import 'package:wasteagram/widgets/waste_list_view/empty_post.dart';

class WasteItems extends StatefulWidget {
  @override
  _WasteItemsState createState() => _WasteItemsState();
}

class _WasteItemsState extends State<WasteItems> {
  WasteBloc _bloc;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WasteagramStateContainer.of(context).blocProvider.wasteBloc;
  }

  Widget _buildListItem(WastedItem document) {
    return ListTile(
      leading: const Icon(Icons.chevron_right),
      title: Row(children: [
        Text(
          Date.humanizeTimestamp(document.date),
          style: TextStyle(fontSize: AppFonts.h3),
        ),
        Text(' (' + Date.dayOfWeek(document.date) + ')'),
      ]),
      trailing: Text(document.count.toString()),
      onTap: () => Routes.wasteDetailPage(context, item: document),
    );
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
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  _buildListItem(snapshot.data[index]));
        }
      },
    ));
  }
}
